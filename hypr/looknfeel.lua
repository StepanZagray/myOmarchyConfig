-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- gaps_out is top/right/bottom/left. The top is tighter because the bar
    -- already reserves its own strip.
    gaps_in = 2,
    gaps_out = { top = 4, right = 7, bottom = 7, left = 7 },
    border_size = 1,

    -- Columns on an infinite horizontal tape.
    -- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
    layout = "scrolling",
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    -- rounding_power 4 is a squircle rather than a circular arc. The shell
    -- reads decoration:rounding for its own corners, so this drives both.
    rounding = 10,
    rounding_power = 4.0,

    -- Omarchy ships with blur off; the translucent shell surfaces need it on.
    blur = {
      enabled = true,
      size = 14,
      passes = 3,
      special = true,
      popups = true,
      input_methods = true,
    },
  },
})

-- Window transparency.
--
-- Omarchy no longer uses decoration:active_opacity. It tags windows with
-- "default-opacity" and applies a window rule, and a window rule beats the
-- decoration variable -- so setting active_opacity here would do nothing.
o.window({ tag = "default-opacity" }, { opacity = "0.9 0.8" })

-- Apps that should stay closer to opaque. Each drops the default-opacity tag
-- first so the rule above cannot fight with the explicit value.
local app_opacity = {
  ["helium"] = "1.0 0.9",
  ["cursor"] = "1.0 0.9",
  ["zen"] = "1.0 0.95",
  ["vivaldi-stable"] = "1.0 0.95",
  -- The app's real Wayland app_id is plain "t3code" (verified with hyprctl).
  -- The old config matched "t3code-nightly", which never matched anything.
  ["t3code"] = "1.0 0.95",
  ["t3code-dev"] = "1.0 0.95",
  ["Minecraft* 1.21.1"] = "1.0 0.95",
}
for class, opacity in pairs(app_opacity) do
  o.window(class, { tag = "-default-opacity" })
  o.window(class, { opacity = opacity })
end

-- https://wiki.hypr.land/Configuring/Basics/Animations/
-- Motion is Omarchy's default speed roughly halved (i.e. twice as fast).
-- Fades and border colour keep Omarchy's defaults.
hl.animation({ leaf = "global", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 2.4, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1, bezier = "linear", style = "fade" })

-- Glass for the Omarchy shell surfaces.
--
-- These namespaces belong to Omarchy's own Quickshell (the previous set of
-- rules targeted ~/.config/quickshell/desktop, which no longer runs).
-- ignore_alpha has to stay BELOW the surface alpha set in
-- ~/.config/omarchy/shell.toml, or the surface is skipped by the blur pass.
hl.layer_rule({ match = { namespace = "omarchy-bar" }, blur = true, ignore_alpha = 0.4 })
-- The copied frame owns the translucent top rail and attached popup pockets.
-- Its shadow peaks below 0.65, so this threshold blurs the glass body without
-- feeding the shadow back into a hard halo.
hl.layer_rule({ match = { namespace = "omarchy-shell-visual" }, blur = true, ignore_alpha = 0.65 })

for _, ns in ipairs({
  "omarchy-menu",
  "omarchy-keyboard-panel", -- every bar flyout: audio, network, bluetooth, power, clock, ...
  "omarchy-notifications",
  "omarchy-osd",
  "omarchy-clipboard",
  "omarchy-emojis",
  "omarchy-polkit",
  "omarchy-image-selector",
  "omarchy-reminders",
}) do
  hl.layer_rule({ match = { namespace = ns }, blur = true, ignore_alpha = 0.2 })
end
