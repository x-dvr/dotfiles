# My Pop!_OS setup :rocket:

## Generate SSH Keys

Generate Key:
```
ssh-keygen -t ed25519 -C "my@email.address"
```
Start SSH Agent & add key:
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github-key
```

## Generate GPG key & Setup GIT to sign commits

```
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <KEY_ID>

git config --global commit.gpgsign true
git config --global user.signingkey <KEY_ID>
```

## Install Zsh and set to be default shell
*https://www.zsh.org/*

```
sudo apt install zsh
zsh --version
chsh -s $(which zsh)
```
- Logout to apply change of default shell
- Choose option to empty .zshrc
- logout and login again
- Check installation okay with `$SHELL --version`

## Setup ZSH

Install plugins:
```
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
```
Add the following to your `.zshrc`:
```
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=(~/.zsh/zsh-completions/src $fpath)
```

## Install starship shell prompt
```
curl -sS https://starship.rs/install.sh | sh
```

## Install fzf
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
Then run install script

## Install Rust lang
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install rust software

```
cargo install fnm
cargo install exa
cargo install ripgrep
cargo install --locked bat
```

## Install nerd fonts

```
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
```

Unzip into `~/.fonts` and execute:
```
fc-cache -f -v
```

## Install Alacritty

```
apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo install alacritty
```
Clone alacrity repo and execte from it:
```
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
```

## Make alacritty default terminal
*https://frantzroulet.com/blog/other/2018/12/26/how-to-choose-alacritty-as-default-terminal.html*

```
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
sudo update-alternatives --config x-terminal-emulator
```

## Install configuration of alacritty

- Place [alacritty.toml](alacritty.toml) in `$HOME/.config/alacritty/alacritty.toml`

Install cattpuccin theme:
```
curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-macchiato.toml
```

## Install go

Download latest go toolchain from https://go.dev/dl/
Then execute:
```
mkdir ~/.go
tar -C ~/.go -xzf go1.22.2.linux-amd64.tar.gz
```