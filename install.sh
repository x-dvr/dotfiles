#!/bin/bash

sudo pacman -Syu
eos-update --yay

sudo pacman -S ttf-font-nerd ttf-font-awesome fastfetch zsh stow fzf eza ripgrep bat btop kitty starship
sudo pacman -S yazi ffmpeg 7zip jq poppler fd zoxide imagemagick
sudo pacman -S zed helix nvim lldb hugo graphviz docker
sudo pacman -S cosmic

yay -S nvidia-dkms nvidia-inst
yay -S brave-bin
yay -S vscodium-bin
yay -S golangci-lint

chsh -s $(which zsh)

# Setup zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions

# Setup grub
sudo grub-mkfont -s 24 -o /boot/grub/font.pf2 /usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf
echo "GRUB_FONT=/boot/grub/font.pf2" | sudo tee -a /etc/default/grub
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Setup docker
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

# Prepare dotfiles
cd ~/dotfiles/stow
stow terminal
stow dev
stow desktop

# Setup nvidia
nvidia-inst
reboot
