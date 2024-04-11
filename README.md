# My Pop!_OS setup :rocket:
Setup 

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

