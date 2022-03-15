#!/usr/bin/env bash
tmp=$(mktemp /tmp/tmp.XXXXXXX)
jq '.profile.exit_type= "Normal" | .profile.exited_cleanly = true' ~/.config/google-chrome/Default/Preferences > "$tmp"
mv "$tmp" ~/.config/google-chrome/Default/Preferences
