#/bin/bash
killall swabg
killall eww

WP_PATH=$(find ~/.local/wallpapers/$THEME -type f | shuf -n 1)
echo $WP_PATH

# Configure Theme
rm -f $HOME/.config/wofi/style.css
rm -f $HOME/.config/kitty/colorschemes/colors.conf
envsubst < $HOME/.config/wofi/style_template.css > $HOME/.config/wofi/style.css
envsubst < $HOME/.config/kitty/theme_template.conf > $HOME/.config/kitty/theme.conf

sleep 0.1
swaybg --image $WP_PATH --mode fill &
systemctl --user start hyprpolkitagent &
dbus-update-activation-environment &
nm-applet &

xrandr --output DP-1 --primary &
xrandr --output HDMI-A-1 --mode 1280x1024 --noprimary --left-of DP-0 &

eww open bar0; eww open bar1
envsubst < $HOME/.config/wofi/style_template.css > $HOME/.config/wofi/style.css
