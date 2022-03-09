#!/usr/bin/env bash

## Shows a drop down menu with power options

case "$(echo -e " Exit sway\n Power Off\n Reboot\n Suspend\n" | wofi --show dmenu --prompt="Select an option")" in
" Exit sway")
  swaymsg exit
  loginctl terminate-user $USER
  ;;
" Power Off") exec systemctl poweroff -i ;;
" Reboot") exec systemctl reboot ;;
" Suspend") exec systemctl suspend ;;
esac
