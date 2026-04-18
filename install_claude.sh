#!/bin/bash

# install claude-code
curl -fsSL https://claude.ai/install.sh | bash

# install status line
cp ./statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

# 2. Add to ~/.claude/settings.json
jq '. + {"statusLine": {"type": "command", "command": "~/.claude/statusline.sh", "padding": 0}}' \
  ~/.claude/settings.json > /tmp/settings.json && mv /tmp/settings.json ~/.claude/settings.json