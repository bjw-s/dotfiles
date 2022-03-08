#!/usr/bin/env bash

socket="${XDG_RUNTIME_DIR:-/run/user/$UID}/yubikey-touch-detector.socket"

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
              --background f58f3c \
              &
            PID=$!
        fi
    done

    sleep 1
done
