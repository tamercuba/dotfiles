export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nano
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/palemoon

setxkbmap -layout us -variant alt-intl -model pc105 -option terminate:ctrl_alt_bksp 2>/dev/null || true
