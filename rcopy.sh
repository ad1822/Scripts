#!/bin/bash

files=("hypr" "waybar" "cava" "fastfetch" "gtk-3.0" "gtk-4.0" "hypridle" "kitty" "k9s" "rofi" "yazi" "starship")

echo "=> Restoring Obsidian Vault"
rclone copy -P gdrive:backup/Obsidian "$HOME/Obsidian Vault"

for dir in "${files[@]}"; do
    echo "=> Restoring $dir"
    rclone copy -P "gdrive:backup/config/$dir" "$HOME/.config/$dir"
done

echo "=> Restoring Wallpaper"
rclone copy -P gdrive:backup/Wallpaper "$HOME/Pictures/Wallpaper"

echo "=> Restoring Scripts"
rclone copy -P gdrive:backup/Scripts "$HOME/Downloads/Scripts"
