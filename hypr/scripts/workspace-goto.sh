#!/usr/bin/env bash
# Focus the monitor where a workspace is pinned (see monitors.conf), then switch.
set -euo pipefail

ws="${1:?workspace number required}"

case "$ws" in
    1|2|3) mon="eDP-2" ;;
    *) mon="DP-2" ;;
esac

hyprctl --batch "dispatch focusmonitor ${mon} ; dispatch workspace ${ws}"
