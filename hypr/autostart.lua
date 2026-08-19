-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Prefer the user-owned Omarchy shell fork. Omarchy's default autostart still
-- calls `omarchy-launch-shell`; prepending this tracked bin directory keeps the
-- stock launcher available as a fallback without editing package-owned files.
local custom_shell_bin = (os.getenv("HOME") or "") .. "/.config/quickshell/bin"
local current_path = os.getenv("PATH") or "/usr/local/bin:/usr/bin"
hl.env("PATH", custom_shell_bin .. ":" .. current_path)
