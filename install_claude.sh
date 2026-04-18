#!/bin/bash

# install claude-code
curl -fsSL https://claude.ai/install.sh | bash

rm -rf ~/.claude

cd ~/dotfiles
stow claude
# install status line
chmod +x ~/.claude/statusline.sh

# 2. Add to ~/.claude/settings.json
# jq '. + {"statusLine": {"type": "command", "command": "~/.claude/statusline.sh", "padding": 0}}' \
#   ~/.claude/settings.json > /tmp/settings.json && mv /tmp/settings.json ~/.claude/settings.json