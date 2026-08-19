-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

hl.config({
  input = {
    -- US + Ukrainian, toggled with Alt+Shift.
    kb_layout = "us,ua",

    -- Omarchy's default is "compose:caps,shift:both_capslock_cancel". Those are
    -- kept and the layout toggle is appended -- setting only grp:alt_shift_toggle
    -- would drop the compose key that ~/.XCompose and fcitx5 depend on.
    kb_options = "compose:caps,shift:both_capslock_cancel,grp:alt_shift_toggle",

    -- Omarchy defaults to 250; 600 is a longer wait before the repeat kicks in.
    repeat_delay = 600,

    -- Slow the mouse down (trackpad gets its own value in the device block below).
    sensitivity = -0.5,

    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.5,

      -- Omarchy turns this on; keep the lower-right-corner right-click instead.
      clickfinger_behavior = false,
    },
  },
})

-- Trackpad-only sensitivity, so the mouse keeps the negative value above.
hl.device({ name = "asuf1209:00-2808:0219-touchpad", sensitivity = 0.5 })

-- Omarchy already ships scroll_touchpad 1.5 for Alacritty/kitty/foot.
-- Ghostty scrolls much faster than the rest, so slow it down further than the
-- 0.2 Omarchy sets.
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.1 })
