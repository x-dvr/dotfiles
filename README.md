# My Linux setup :rocket:

## Install

```bash
git clone git@github.com:x-dvr/dotfiles.git
cd dotfiles
bash ./install.sh
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
