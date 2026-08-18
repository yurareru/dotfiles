-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local is_laptop = require "utils".is_laptop()
local exec = hl.exec_cmd

hl.on("hyprland.start", function()
    exec("waybar")
    exec("hyprpaper")
    exec("udiskie")
    exec("wl-paste --watch cliphist store")
    if is_laptop then
        exec("hypridle")
    else
        exec("xrandr --output DP-1 --primary")
    end
end)

hl.on("config.reloaded", function()
    exec("pkill waybar; waybar")
    if is_laptop then
        exec("pkill hypridle; hypridle")
    end
end)
