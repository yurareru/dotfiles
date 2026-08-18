local M = {}

function M.notify(text)
    hl.notification.create { text = text, timeout = 3000 }
end

function M.is_laptop()
    return io.open("/sys/class/power_supply/BAT1") ~= nil
end

function M.toggle_layout()
    local ws = hl.get_active_workspace()

    if not ws then
        return
    end
    if ws.tiled_layout == "scrolling" then
        hl.workspace_rule { workspace = tostring(ws.id), layout = "dwindle" }
    else
        hl.workspace_rule { workspace = tostring(ws.id), layout = "scrolling" }
    end
end

function M.toggle_eye_candy()
    local mode = (hl.get_config("animations.enabled") == false)

    if mode then
        hl.exec_cmd("hyprctl reload")
        return
    end

    hl.config {
        general = {
            gaps_in = 0,
            gaps_out = 0,
            border_size = 0,
        },

        animations = {
            enabled = false,
        },

        decoration = {
            shadow = { enabled = false },
            blur = { enabled = false },
            rounding = 0,
        }
    }
end

return M
