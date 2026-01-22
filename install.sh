#!/bin/bash

sudo pacman -Syu
eos-update --yay

sudo pacman -S ttf-font-nerd ttf-firacode-nerd ttf-font-awesome fastfetch zsh stow fzf eza ripgrep bat btop kitty starship
sudo pacman -S yazi ffmpeg 7zip jq poppler fd zoxide imagemagick
sudo pacman -S zed helix nvim lldb hugo graphviz docker
sudo pacman -S cosmic

yay -S ttf-jetbrains-mono-nerd
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
sudo grub-mkfont -s 28 -o /boot/grub/font.pf2 /usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf
echo "GRUB_FONT=/boot/grub/font.pf2" | sudo tee -a /etc/default/grub
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

# Setup docker
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo systemctl enable docker

# Setup Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install cargo-update

# Install cargo software
cargo install fnm
cargo install cargo-audit
cargo install codebook-lsp

# Setup Zig (zvm)
curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash
source ~/.zshenv
zvm i --zls master

# Prepare dotfiles
cd ~/dotfiles
stow terminal
stow dev
stow desktop

# Install Go manager
curl -fsSL https://raw.githubusercontent.com/x-dvr/gm/master/install.sh | bash
source ~/.zshenv

# Install Go toolchain
gm i latest

# Install Go software
# debugger
go install github.com/go-delve/delve/cmd/dlv@latest
# language server
go install golang.org/x/tools/gopls@latest
# lint lsp
go install github.com/nametake/golangci-lint-langserver@latest
# update tool
go install github.com/nao1215/gup@latest
# cobra cli
go install github.com/spf13/cobra-cli@latest
# go releaser
go install github.com/goreleaser/goreleaser/v2@latest

# install bun
curl -fsSL https://bun.sh/install | bash

# Setup integrated video
sudo pacman -S vulkan-intel

# Setup nvidia
nvidia-inst
reboot
