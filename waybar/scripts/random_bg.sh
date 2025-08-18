
#!/usr/bin/env bash

WALLPAPER_LAND="$HOME/Pictures/cthulhu/landscape"
WALLPAPER_PORT="$HOME/Pictures/cthulhu/portrait/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER_LS=$(find "$WALLPAPER_LAND" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
WALLPAPER_PT=$(find "$WALLPAPER_PORT" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

echo "$WALLPAPER_LAND ---"
echo "$WALLPAPER_PORT -|-"
echo "$CURRENT_WALL ---!"
echo "$WALLPAPER_LS -----"
echo "$WALLPAPER_PT -----"
# Apply the selected wallpaper
# killall hyprpaper & hyprpaper
hyprctl hyprpaper reload DP-2,"$WALLPAPER_PT"
hyprctl hyprpaper reload HDMI-A-1,"$WALLPAPER_LS"
# swww img "$WALLPAPER_PT" --transition-type center




# hyprctl hyprpaper wallpaper "DP-1,$WALLPAPER_PT"
