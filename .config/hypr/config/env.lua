-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

local env = hl.env

env("XCURSOR_SIZE", "24")
env("HYPRCURSOR_SIZE", "24")

env("QT_QPA_PLATFORM", "wayland;xcb")
env("QT_QPA_PLATFORMTHEME", "qt6ct")
env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

env("GDK_BACKEND", "wayland,x11,*")

env("SDL_VIDEODRIVER", "wayland")
env("CLUTTER_BACKEND", "wayland")

env("XDG_CURRENT_DESKTOP", "Hyprland")
env("XDG_SESSION_TYPE", "wayland")
env("XDG_SESSION_DESKTOP", "Hyprland")

env("GBM_BACKEND", "nvidia-drm")
env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
env("LIBVA_DRIVER_NAME", "nvidia")
