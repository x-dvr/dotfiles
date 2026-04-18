#!/bin/bash

sudo pacman -Syu

sudo pacman -S hyprland xdg-desktop-portal-hyprland hyprlock hypridle
sudo pacman -Sy wl-clipboard grim slurp swaybg ttf-jetbrains-mono-nerd
sudo pacman -S hyprlauncher hyprpaper hyprpolkitagent waybar hyprshot
sudo pacman -S swaync # remove dunst if needed

paru -S qt5-wayland qt6-wayland
paru -S hyprshutdown
paru -Sy nwg-look catppuccin-gtk-theme-frappe