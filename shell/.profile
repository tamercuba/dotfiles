export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export BROWSER=/usr/bin/firefox

if [ "$(uname)" = "Darwin" ]; then
    export TERMINAL="kitty"
else
    export TERMINAL="alacritty"
fi

setxkbmap -layout us -variant alt-intl -model pc105 -option terminate:ctrl_alt_bksp 2>/dev/null || true
