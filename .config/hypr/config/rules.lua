--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
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
})

hl.window_rule({
	name = "discord",
	match = { class = "discord" },
	workspace = 1,
})

hl.layer_rule({
	name = "blur-layer",
	match = { namespace = "waybar|rofi|logout_dialog" },
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	name = "disable-animation",
	match = { namespace = "hyprpicker|selection" },
	no_anim = true,
})

hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide right" })
