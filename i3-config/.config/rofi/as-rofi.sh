#!/bin/bash

if [ $# -eq 0 ]; then
    ~/.config/rofi/audio-switcher.sh | rofi -dmenu \
        -p "" \
        -theme ~/.config/rofi/audio-menu.rasi \
        -no-custom \
        -no-show-match \
        -no-sort \
        -no-case-sensitive \
        -selected-row 0 | xargs -I {} ~/.config/rofi/audio-switcher.sh "{}"
else
    ~/.config/rofi/audio-switcher.sh "$@"
fi
