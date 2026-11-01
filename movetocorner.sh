#!/bin/bash
# Sofiane Hamlaoui
# Adapted to align to screen borders (abnergamer1)

selection=$1
{ read max_x max_y ; } < <(xrandr -q | grep -w "connected" | grep -oE '[0-9]+x[0-9]+' | head -n 1 | tr 'x' ' ')
{ read window_id ; } < <(xdotool getactivewindow)
{ read window_g_x window_g_y ; } < <(xdotool getwindowfocus getwindowgeometry | grep Geometry | cut -d ":" -f2 | sed 's/ //g' | sed 's/x/ /g')

half_x=$(( (max_x - window_g_x) / 2 ))
half_y=$(( (max_y - window_g_y) / 2 ))

max_pos_x=$(( max_x - window_g_x ))
max_pos_y=$(( max_y - window_g_y ))

case $selection in 
    '1') new_pos="0 0";;                                                # Canto superior esquerdo
    '2') new_pos="$half_x 0";;                                          # Centro superior
    '3') new_pos="$max_pos_x 0";;                                       # Canto superior direito
    '4') new_pos="0 $half_y";;                                          # Centro esquerdo
    '5') new_pos="$half_x $half_y";;                                    # Centro exato da tela
    '6') new_pos="$max_pos_x $half_y";;                                 # Centro direito
    '7') new_pos="0 $max_pos_y";;                                       # Canto inferior esquerdo
    '8') new_pos="$half_x $max_pos_y";;                                 # Centro inferior
    '9') new_pos="$max_pos_x $max_pos_y";;                              # Canto inferior direito
    *) echo "Invalid preset \"$selection\"" >&2; exit 2;;
esac 

xdotool windowmove $window_id $new_pos
