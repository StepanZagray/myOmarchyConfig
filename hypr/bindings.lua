-- Personal keybinding overrides.
--
-- See current bindings and descriptions:
--   omarchy menu keybindings --print
--
-- Anything already matching an Omarchy default was dropped rather than
-- restated here: the app and web-app launchers, the notification controls,
-- the volume/brightness/keyboard-backlight keys are all bound the same way
-- out of the box now.

-- Restore the previous custom shell's dedicated frame-attached surfaces.
hl.unbind("SUPER + ESCAPE")
hl.unbind("XF86PowerOff")
o.bind("SUPER + ESCAPE", "System menu", "omarchy-shell shell toggle omarchy.system-menu")
o.bind("XF86PowerOff", "Power menu", "omarchy-shell shell toggle omarchy.system-menu", { locked = true })
o.bind("SUPER + M", "Media widget", "omarchy-shell shell toggle omarchy.media")

-- Typora. SUPER+SHIFT+W is Omawrite by default.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Typora", { launch = "typora --enable-wayland-ime" })

-- Capture. Omarchy puts these on PRINT / ALT+PRINT; these are the extra
-- keys, kept from the old config. SUPER+ALT+P is unbound by default.
o.bind("SUPER + ALT + P", "Screenshot to clipboard", "omarchy-capture-screenshot smart copy")

-- SUPER+ALT+S is "Move window to scratchpad" by default, which pulls the
-- window out of the tiled layout.
hl.unbind("SUPER + ALT + S")
o.bind("SUPER + ALT + S", "Screen recording", "omarchy-capture-screenrecording")

-- Scrolling layout: move along the tape.
-- Omarchy has no bindings for these. Note the lower-case `comma` -- xkbcommon
-- names the keysym `comma` and an upper-case COMMA will not match.
-- SUPER+comma is "Dismiss last notification" by default.
hl.unbind("SUPER + comma")
o.bind("SUPER + comma", "Scroll layout -1 column", hl.dsp.layout("move -col"))
o.bind("SUPER + PERIOD", "Scroll layout +1 column", hl.dsp.layout("move +col"))
o.bind("SUPER + SHIFT + PERIOD", "Swap column left", hl.dsp.layout("swapcol l"))

-- Column width (scrolling layout). code:20 is minus, code:21 is equals.
-- Both are bound to dwindle-style window resize by default.
for _, key in ipairs({
  "SUPER + code:20",
  "SUPER + code:21",
  "SUPER + ALT + code:20",
  "SUPER + ALT + code:21",
}) do
  hl.unbind(key)
end
o.bind("SUPER + code:20", "Column width -0.1", hl.dsp.layout("colresize -0.1"))
o.bind("SUPER + code:21", "Column width +0.1", hl.dsp.layout("colresize +0.1"))
o.bind("SUPER + ALT + code:20", "Column width -0.5", hl.dsp.layout("colresize -0.5"))
o.bind("SUPER + ALT + code:21", "Column width +0.5", hl.dsp.layout("colresize +0.5"))
