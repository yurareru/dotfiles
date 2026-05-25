-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local exec = hl.exec_cmd

hl.on("hyprland.start", function()
	exec("waybar")
	exec("hyprpaper")
	exec("udiskie")
	exec("wl-paste --watch cliphist store")
	exec("xrandr --output DP-1 --primary")
end)
