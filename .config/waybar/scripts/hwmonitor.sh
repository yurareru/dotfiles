#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/waybar/hw_cycle_state"
CACHE_DIR="$HOME/.cache/waybar"
RAPL_POWER_USAGE_PATH="/sys/class/powercap/intel-rapl:0/energy_uj"
CPU_POWER_FILE="$CACHE_DIR/cpu_power"
CPU_TIME_FILE="$CACHE_DIR/cpu_time"

mkdir -p "$CACHE_DIR"

[[ -f $STATE_FILE ]] || echo 0 >"$STATE_FILE"
state=$(<"$STATE_FILE")

case "$1" in
  next)
    ((state = (state + 1) % 3))
    echo "$state" >"$STATE_FILE"
    exit 0
    ;;
  prev)
    ((state = (state + 2) % 3))
    echo "$state" >"$STATE_FILE"
    exit 0
    ;;
esac

cpu_usage=$(top -bn1 | awk '/Cpu\(s\)/ {print 100 - $8}')
printf -v cpu_usage "%.0f" "$cpu_usage"

cpu_temp=$(sensors | awk '/Tctl:/ {gsub("\\+",""); print int($2); exit}')

cpu_watt="N/A"
if [[ -r $RAPL_POWER_USAGE_PATH ]]; then
    curr_energy=$(<"$RAPL_POWER_USAGE_PATH")
    curr_time=$(date +%s%6N)

    if [[ -f $CPU_POWER_FILE && -f $CPU_TIME_FILE ]]; then
        prev_energy=$(<"$CPU_POWER_FILE")
        prev_time=$(<"$CPU_TIME_FILE")
        ((delta_energy = curr_energy - prev_energy))
        ((delta_time  = curr_time  - prev_time))
        if (( delta_time > 0 )); then
            cpu_watt=$(awk "BEGIN {printf \"%.1f\", $delta_energy / $delta_time}")
        fi
    fi

    echo "$curr_energy" >"$CPU_POWER_FILE"
    echo "$curr_time"   >"$CPU_TIME_FILE"
fi

read -r used_mb total_mb < <(free -m | awk '/Mem:/ {print $3, $2}')
used_gb=$(awk "BEGIN {printf \"%.2f\", $used_mb/1024}")
total_gb=$(awk "BEGIN {printf \"%.2f\", $total_mb/1024}")
ram_pct=$(awk "BEGIN {printf \"%.0f\", ($used_mb/$total_mb)*100}")
ram_info="${used_gb}GB / ${total_gb}GB (${ram_pct}%%)"

gpu=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,power.draw --format=csv,noheader,nounits)

gpu_util=$(echo "$gpu" | awk -F',' '{print $1}' | xargs)
gpu_temp=$(echo "$gpu" | awk -F',' '{print $2}' | xargs)
gpu_watt=$(echo "$gpu" | awk -F',' '{print $3}' | xargs)

case $state in
  0)
    if [[ -r $RAPL_POWER_USAGE_PATH ]]; then
        printf "%s%% %s°C %sW " "$cpu_usage" "$cpu_temp" "$cpu_watt"
    else
        printf "%s%% %s°C " "$cpu_usage" "$cpu_temp"
    fi
    ;;
  1)
    printf "%s%% %s°C %sW " "$gpu_util" "$gpu_temp" "$gpu_watt"
    ;;
  2)
    printf "%s " "$ram_info"
    ;;
esac
