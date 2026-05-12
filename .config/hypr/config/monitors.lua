------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "HDMI-A-1", mode = "1600x900@60", position = "auto", scale = "1" })
hl.monitor({ output = "DP-1", mode = "1920x1080@165", position = "auto", scale = "1" })

for i = 1, 2 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", persistent = true })
end
for i = 3, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end
