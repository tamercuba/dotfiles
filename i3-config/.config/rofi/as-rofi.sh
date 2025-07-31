#!/bin/bash

if [ $# -eq 0 ]; then
    ~/.config/rofi/audio-switcher.sh | rofi -dmenu -p "Selecione saída de áudio:" -theme-str 'window {width: 50%;}' | xargs -I {} ~/.config/rofi/audio-switcher.sh "{}"
else
    ~/.config/rofi/audio-switcher.sh "$@"
fi
