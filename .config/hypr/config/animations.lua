-- see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.curve("quick_overshoot", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("overshoot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "quick_overshoot", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshoot", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 6, bezier = "quick_overshoot", style = "slide" })
