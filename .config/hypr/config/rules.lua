--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Windows

hl.window_rule {
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
}

hl.window_rule {
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
}

hl.window_rule {
	name = "discord",
	match = { class = "discord" },
	workspace = "1 silent",
}

--[[ hl.window_rule {
	name = "maximize-window",
	match = { class = "librewolf|discord|com.obsproject.Studio" },
	maximize = true,
} ]]

hl.window_rule {
	name = "fullscreen-window",
	match = { class = "Waydroid" },
	fullscreen = true,
}

-- Layers

hl.layer_rule {
	name = "blur-layer",
	match = { namespace = "waybar|rofi|logout_dialog|quickshell-bar" },
	blur = true,
	ignore_alpha = 0,
}

hl.layer_rule {
	name = "disable-animation",
	match = { namespace = "hyprpicker|selection" },
	no_anim = true,
}

hl.layer_rule { match = { namespace = "logout_dialog" }, animation = "fade" }
hl.layer_rule { match = { namespace = "swaync-control-center" }, animation = "slide right" }
