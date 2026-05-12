---------------------
---- KEYBINDINGS ----
---------------------

-- see https://wiki.hypr.land/Configuring/Basics/Binds/

local terminal = "kitty"
local file_manager = "nemo"
local browser = "librewolf"
local menu = "pkill rofi || rofi -show drun -calc-command \"wl-copy -- '{result}'\""
local clipboard = "pkill rofi || sh $HOME/.local/bin/cliphistory"
local emoji = "pkill rofi || rofi -show emoji"
local grimblast = "~/.local/bin/grimblast -nf"
local screenshot = "~/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png"

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + T", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + V", hl.dsp.exec_cmd(clipboard))
hl.bind("SUPER + PERIOD", hl.dsp.exec_cmd(emoji))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

hl.bind("F11", hl.dsp.window.fullscreen())
hl.bind("SUPER + F11", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + W", hl.dsp.window.close())

hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + S", hl.dsp.layout("togglesplit"))

hl.bind("Print", hl.dsp.exec_cmd(grimblast .. " copy area"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd(grimblast .. " copysave area " .. screenshot))
hl.bind("F12", hl.dsp.exec_cmd(grimblast .. " copy output"))
hl.bind("SUPER + F12", hl.dsp.exec_cmd(grimblast .. " copysave output " .. screenshot))

hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("pkill wlogout || wlogout"))
hl.bind("SUPER + SHIFT + DELETE", hl.dsp.exit())
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("pkill waybar; hyprctl reload; waybar"))

hl.bind("SUPER + Z", hl.dsp.exec_cmd("pamixer --default-source -t"))

local directions = {
	{ "left", "H", -10, 0 },
	{ "right", "L", 10, 0 },
	{ "up", "K", 0, -10 },
	{ "down", "J", 0, 10 },
}

for _, pair in ipairs(directions) do
	local direction = pair[1]
	local key = pair[2]
	local x = pair[3]
	local y = pair[4]

	local focus = hl.dsp.focus({ direction = direction })
	local move = hl.dsp.window.move({ direction = direction })
	local resize = hl.dsp.window.resize({ x = x, y = y, relative = true })

	hl.bind("SUPER + " .. direction, focus)
	hl.bind("SUPER + " .. key, focus)

	hl.bind("SUPER + SHIFT + " .. direction, move)
	hl.bind("SUPER + SHIFT + " .. key, move)

	hl.bind("SUPER + ALT + " .. direction, resize, { repeating = true })
	hl.bind("SUPER + ALT + " .. key, resize, { repeating = true })
end

for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
