#!/bin/bash

sudo pacman -Syu

sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprlock hypridle
sudo pacman -S hyprlauncher hyprpaper hyprpolkitagent waybar hyprshot
sudo pacman -S swaync # remove dunst if needed

paru -Sy nwg-look catppuccin-gtk-theme-frappe