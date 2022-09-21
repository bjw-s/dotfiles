#!/usr/bin/env bash
tmp=$(mktemp /tmp/tmp.XXXXXXX)
jq '.profile.exit_type= "Normal" | .profile.exited_cleanly = true' ~/.config/microsoft-edge/Default/Preferences > "$tmp"
mv "$tmp" ~/.config/microsoft-edge/Default/Preferences
