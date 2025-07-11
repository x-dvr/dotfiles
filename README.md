# My EOS setup :rocket:

## Update

```bash
eos-update --yay
```

## Generate SSH Keys

Generate Key:
```bash
ssh-keygen -t ed25519 -C "denis.rodin@proton.me"
```
Start SSH Agent & add key:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github
```

## Generate GPG key & Setup GIT to sign commits

```bash
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <KEY_ID>

git config --global commit.gpgsign true
git config --global user.signingkey <KEY_ID>
```

## Install VSCodium
```bash
yay -S vscodium-bin
```

## Install Brave
https://brave.com/

Add catppuccin theme: https://chromewebstore.google.com/detail/catppuccin-chrome-theme-m/cmpdlhmnmjhihmcfnigoememnffkimlk

## Install Catppuccin theme for KDE
https://github.com/catppuccin/kde

```bash
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde
./install.sh
```

## Install Krohnkite
Download script from releases:
https://github.com/anametologin/krohnkite

Install:
```bash
# install
kpackagetool6 -t KWin/Script -i krohnkite-x.x.x.x.kwinscript
# update
kpackagetool6 -t KWin/Script -u krohnkite-x.x.x.x.kwinscript
```

## Install Ghostty
```bash
pacman -S ghostty
```

## Install Zsh and set to be default shell
*https://www.zsh.org/*

```bash
sudo pacman -S zsh
zsh --version
chsh -s $(which zsh)
```
- Logout to apply change of default shell
- Choose option to empty .zshrc
- logout and login again
- Check installation okay with `$SHELL --version`

## Setup Zsh
Install plugins:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
```
Add the following to your `.zshrc`:
```bash
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(~/.zsh/zsh-completions/src $fpath)
```

## Install starship shell prompt
```bash
curl -sS https://starship.rs/install.sh | sh
```

## Install fzf, exa, ripgrep, bat, helix, lldb, hugo, graphviz
```bash
sudo pacman -S fzf
sudo pacman -S exa
sudo pacman -S ripgrep
sudo pacman -S bat
sudo pacman -S helix
sudo pacman -S lldb
sudo pacman -S hugo
sudo pacman -S graphviz
yay golangci-lint
```

## Install yazi and deps.
```bash
sudo pacman -S yazi ffmpeg 7zip jq poppler fd zoxide imagemagick
```

## Install nerd fonts
https://www.nerdfonts.com/font-downloads
```bash
# Download
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Go-Mono.zip
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Lekton.zip
# Unzip
unzip FiraCode.zip -d ~/.fonts
unzip Go-Mono.zip -d ~/.fonts
unzip JetBrainsMono.zip -d ~/.fonts
unzip Lekton.zip -d ~/.fonts
```
Execute:
```bash
fc-cache -f -v
```

## Install Go lang
Download latest go toolchain from https://go.dev/dl/
Then execute:
```bash
mkdir ~/.go
tar -C ~/.go -xzf go1.24.1.linux-amd64.tar.gz
```

## Install Go software
```bash
# debugger
go install github.com/go-delve/delve/cmd/dlv@latest
# language server
go install golang.org/x/tools/gopls@latest
# lint lsp
go install github.com/nametake/golangci-lint-langserver@latest
```

## Install Rust lang
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install rust software
```bash
cargo install fnm
cargo install cargo-audit
```

## Install Zig Lang
First install zvm:
```bash
curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash
source ~/.zshenv
```
And then latest zig version:
```bash
zvm i --zls master
# or
zvm i --zls 0.14.0
```

## Adjust grub screen
Copy `splash.png` to /usr/share/endeavouros
Prepare font:
```bash
sudo grub-mkfont -s 24 -o /boot/grub/font.pf2 ~/.fonts/FiraCodeNerdFont-Regular.ttf
echo "GRUB_FONT=/boot/grub/font.pf2" | sudo tee -a /etc/default/grub
echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
```
Update grub config:
```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Install fastfetch
```bash
pacman -S fastfetch
```
## Install codebook for spellchecking:
Download from: https://github.com/blopker/codebook/releases
Unarchive to `~/bin` folder:
```bash
tar -xvzf codebook-lsp-x86_64-unknown-linux-gnu.tar.gz -C ~/bin/
```

## Install docker
```bash
sudo pacman -Syu
sudo pacman -S docker

sudo usermod -aG docker $USER

sudo systemctl start docker
sudo systemctl enable docker

```