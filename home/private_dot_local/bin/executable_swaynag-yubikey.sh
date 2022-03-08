#!/usr/bin/env bash

socket="${XDG_RUNTIME_DIR:-/run/user/$UID}/yubikey-touch-detector.socket"
WAL_COLORS_FILE="$HOME/.cache/wal/colors.sh"

if [ -f "${WAL_COLORS_FILE}" ]; then
    source "${WAL_COLORS_FILE}"
    background_color="${color6}"
    text_color="${foreground}"
else
    background_color="f58f3c"
    text_color="ffffff"
fi

while true; do
    PID=""
    touch_reasons=()

    if [ ! -e "$socket" ]; then
        printf 'Waiting for YubiKey socket\n'
        while [ ! -e "$socket" ]; do sleep 1; done
    fi

    nc -U "$socket" | while read -n5 cmd; do
        reason="${cmd:0:3}"

        if [ "${cmd:4:1}" = "1" ]; then
            touch_reasons+=("$reason")
        else
            for i in "${!touch_reasons[@]}"; do
                if [ "${touch_reasons[i]}" = "$reason" ]; then
                    unset 'touch_reasons[i]'
                    break
                fi
            done
        fi

        if [ "${#touch_reasons[@]}" -eq 0 ]; then
            kill $PID
            unset 'PID'
        else
            swaynag \
              -m "Yubikey is waiting for touch input" \
              -s "Dismiss" \
              --background "${background_color}" \
              --text "${text_color}" \
              &
            PID=$!
        fi
    done

    sleep 1
done
