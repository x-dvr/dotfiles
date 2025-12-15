#!/bin/bash

sudo pacman -Syu
yay -Syu
eos-update --yay

# rust
rustup self update
cargo install-update -a

# zig
zvm upgrade


# update go soft
