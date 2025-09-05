#!/usr/bin/env bash

STATE_FILE="/tmp/waybar_hw_cycle_state"
[ ! -f "$STATE_FILE" ] && echo 0 > "$STATE_FILE"
state=$(<"$STATE_FILE")

if [ "$1" = "next" ]; then
    next_state=$(( (state + 1) % 3 ))
    echo "$next_state" > "$STATE_FILE"
    exit 0
elif [ "$1" = "prev" ]; then
    prev_state=$(( (state + 2) % 3 ))
    echo "$prev_state" > "$STATE_FILE"
    exit 0
fi

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
cpu_usage=$(printf "%.0f" "$cpu_usage")
cpu_temp=$(($(cat /sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input) / 1000))

ram_info=$(free -m | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

gpu=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu,power.draw \
    --format=csv,noheader,nounits)

gpu_util=$(echo "$gpu" | awk -F',' '{print $1}' | xargs)
gpu_temp=$(echo "$gpu" | awk -F',' '{print $2}' | xargs)
gpu_watt=$(echo "$gpu" | awk -F',' '{print $3}' | xargs)

case $state in
    0)
        printf "%s%% %s°C " "$cpu_usage" "$cpu_temp" ;;
    1)
        printf "%s%% %s°C %sW " "$gpu_util" "$gpu_temp" "$gpu_watt" ;;
    2)
        printf "%s%% " "$ram_info" ;;
esac
