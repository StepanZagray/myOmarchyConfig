-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 2
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Internal panel + external 4K (USB-C), both driven by the Intel iGPU.
-- DP-2 sits directly above the laptop panel, nudged left so the two centres line up.
hl.monitor({ output = "eDP-2", mode = "2560x1600@240", position = "0x0", scale = 1.6 })
-- hl.monitor({ output = "DP-2", mode = "3840x2160@60", position = "-160x-1080", scale = 2 })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60", position = "-160x-1080", scale = 2 })

-- Workspaces 1-3 live on the laptop, 4-10 on the LU28R55.
for ws = 1, 3 do
  hl.workspace_rule({ workspace = tostring(ws), monitor = "eDP-2" })
end
for ws = 4, 10 do
  hl.workspace_rule({ workspace = tostring(ws), monitor = "HDMI-A-1" })
end

-- Environment overrides.
--
-- Omarchy's default/hypr/nvidia.lua sets LIBVA_DRIVER_NAME=nvidia whenever a
-- GSP-capable NVIDIA card is present, which this machine has. We want video
-- decode on the Intel iGPU, so re-set it here: this file is required after
-- Omarchy's defaults, so it wins.
--
-- AQ_DRM_DEVICES is deliberately NOT set here -- ~/.config/uwsm/env-hyprland
-- already pins the iGPU-first device order before the compositor starts.
hl.env("LIBVA_DRIVER_NAME", "iHD")
