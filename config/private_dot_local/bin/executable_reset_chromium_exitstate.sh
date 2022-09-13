#!/usr/bin/env bash
tmp=$(mktemp /tmp/tmp.XXXXXXX)
jq '.profile.exit_type= "Normal" | .profile.exited_cleanly = true' ~/.config/chromium/Default/Preferences > "$tmp"
mv "$tmp" ~/.config/chromium/Default/Preferences
