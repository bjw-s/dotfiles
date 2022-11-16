#!/usr/bin/env bash

app_id=$( swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused==true) | .app_id'  )
if [[ $app_id != "org.keepassxc.KeePassXC" ]]; then
    # --no-persist so that we preserve rich text:
    clipman store --no-persist
fi
