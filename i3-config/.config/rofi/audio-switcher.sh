#!/bin/bash

get_sinks() {
    pactl list short sinks | while read -r line; do
        sink_id=$(echo "$line" | awk '{print $1}')
        sink_name=$(echo "$line" | awk '{print $2}')
        
        description=$(pactl list sinks | grep -A 20 "Sink #$sink_id" | grep "Description:" | cut -d: -f2- | xargs)
        
        # Remove my monitor from list
        if [[ "$description" == *"HDMI"* ]]; then
            continue
        fi
        
        # Devices aliases
        case "$description" in
            *"Starship/Matisse"*)
                description="Headphone"
                ;;
            *"PCM2902"*)
                description="Speakers"
                ;;
        esac
        
        current_default=$(pactl get-default-sink)
        if [[ "$sink_name" == "$current_default" ]]; then
            echo "● $description"
        else
            echo "○ $description"
        fi
    done
}

move_all_streams() {
    local new_sink="$1"
    pactl list short sink-inputs | while read -r stream; do
        stream_id=$(echo "$stream" | awk '{print $1}')
        pactl move-sink-input "$stream_id" "$new_sink"
    done
}

if [ $# -eq 0 ]; then
    get_sinks
else
    selected="$1"
    selected_clean=$(echo "$selected" | sed 's/^[●○] //')
    
    case "$selected_clean" in
        "Headphone")
            search_term="Starship/Matisse"
            ;;
        "Speakers")
            search_term="PCM2902"
            ;;
        *)
            search_term="$selected_clean"
            ;;
    esac
    
    sink_name=$(pactl list sinks | grep -B 20 "Description:.*$search_term" | grep "Name:" | head -1 | awk '{print $2}')
    
    if [ -n "$sink_name" ]; then
        pactl set-default-sink "$sink_name"
        move_all_streams "$sink_name"
        
        dunstify -i audio-volume-high -r 2593 -u normal "🔊 Áudio alternado" "   $selected_clean"
    fi
fi
