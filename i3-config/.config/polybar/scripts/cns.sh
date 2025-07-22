
# #!/bin/bash

function capslock() {

  caps=$(xset -q | grep Caps | awk '{ print $4 }')

  if [ $caps == 'off' ]; then
    echo "%{T1} 󰌎 %{T-}"
  else
    echo "%{T1}  %{T-}"
  fi

}

main () {

  if [ "$1" == "-c"  ]; then
    capslock
  fi
}

main $1
