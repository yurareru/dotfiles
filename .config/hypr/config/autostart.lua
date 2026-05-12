-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("udiskie")
	hl.exec_cmd("wl-paste --watch cliphist store")
	hl.exec_cmd("xrandr --output DP-1 --primary")
end)
