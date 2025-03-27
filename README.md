# My EOS setup :rocket:

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
yay -S vscodium
```

## Install Brave
https://brave.com/

Add cacppuccin theme: https://chromewebstore.google.com/detail/catppuccin-chrome-theme-m/cmpdlhmnmjhihmcfnigoememnffkimlk

## Install Catppuccin theme for KDE
https://github.com/catppuccin/kde

```bash
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde
./install.sh
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

## Install fzf, exa, ripgrep, bat
```bash
sudo pacman -S fzf
sudo pacman -S exa
sudo pacman -S ripgrep
sudo pacman -S bat
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

## Install Rust lang
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install rust software
```bash
cargo install fnm
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