# My Pop!_OS setup :rocket:

## Generate SSH Keys

Generate Key:
```bash
ssh-keygen -t ed25519 -C "my@email.address"
```
Start SSH Agent & add key:
```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github-key
```

## Generate GPG key & Setup GIT to sign commits

```bash
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <KEY_ID>

git config --global commit.gpgsign true
git config --global user.signingkey <KEY_ID>
```

## Install Zsh and set to be default shell
*https://www.zsh.org/*

```bash
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

## Install fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```
Then run install script

## Install Rust lang
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Install rust software

```bash
cargo install fnm
cargo install exa
cargo install ripgrep
cargo install --locked bat
```

## Install nerd fonts

```bash
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
```

Unzip into `~/.fonts` and execute:
```bash
fc-cache -f -v
```

## Install Alacritty

```bash
apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo install alacritty
```
Clone alacrity repo and execte from it:
```bash
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
```

## Make alacritty default terminal
*https://frantzroulet.com/blog/other/2018/12/26/how-to-choose-alacritty-as-default-terminal.html*

```bash
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
sudo update-alternatives --config x-terminal-emulator
```

## Install configuration of alacritty

- Place [alacritty.toml](alacritty.toml) in `$HOME/.config/alacritty/alacritty.toml`

Install cattpuccin theme:
```bash
curl -LO --output-dir ~/.config/alacritty https://github.com/catppuccin/alacritty/raw/main/catppuccin-macchiato.toml
```

## Install Wezterm

Configure apt repo:
```bash
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
```
Update:
```bash
sudo apt update
```
Install:
```bash
sudo apt install wezterm
```

## Make wezterm default terminal

```bash
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which wezterm) 50
sudo update-alternatives --config x-terminal-emulator
```

## Install go

Download latest go toolchain from https://go.dev/dl/
Then execute:
```bash
mkdir ~/.go
tar -C ~/.go -xzf go1.22.2.linux-amd64.tar.gz
```