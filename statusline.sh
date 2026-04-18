#!/bin/bash
# Claude Code status line — Catppuccin Frappe powerline style
# Receives JSON session data on stdin, prints a single colored line
# Requires a Nerd Font (e.g. any Nerd Font patched terminal font)
#
# Setup:
#   1. Save this file to ~/.claude/statusline.sh
#   2. chmod +x ~/.claude/statusline.sh
#   3. Add to ~/.claude/settings.json:
#      {
#        "statusLine": {
#          "type": "command",
#          "command": "~/.claude/statusline.sh",
#          "padding": 0
#        }
#      }
#   4. Restart Claude Code — the bar appears at the bottom of your terminal
#
# Segments (left to right):
#   [model] [git branch +staged ~modified] [context bar % $cost duration] [output style] [agent] [vim mode]
#
# Dependencies: jq, git, awk, md5/md5sum

input=$(cat)

# Catppuccin Frappe — truecolor ANSI
BG_BLUE=$'\e[48;2;140;170;238m'
BG_GREEN=$'\e[48;2;166;209;137m'
BG_YELLOW=$'\e[48;2;229;200;144m'
BG_MAUVE=$'\e[48;2;202;158;230m'
BG_TEAL=$'\e[48;2;129;200;190m'
BG_PEACH=$'\e[48;2;239;159;118m'
FG_BASE=$'\e[38;2;48;52;70m'
FG_DIM=$'\e[38;2;115;121;148m'   # Catppuccin Frappe overlay0 — for empty bar portion

# Foreground versions of segment bg colors — used for powerline arrow transitions
FG_BLUE=$'\e[38;2;140;170;238m'
FG_GREEN=$'\e[38;2;166;209;137m'
FG_YELLOW=$'\e[38;2;229;200;144m'
FG_MAUVE=$'\e[38;2;202;158;230m'
FG_TEAL=$'\e[38;2;129;200;190m'
FG_PEACH=$'\e[38;2;239;159;118m'

BOLD=$'\e[1m'
RESET=$'\e[0m'

# Nerd Font powerline glyphs
SEP=$'\ue0b0'    # U+E0B0 right-arrow: fg=prev_bg, bg=next_bg
CAP_L=$'\ue0b6' # U+E0B6 left rounded cap
CAP_R=$'\ue0b4' # U+E0B4 right rounded cap
CHIP=$'\uf2db'   # U+F2DB fa-microchip
BRANCH=$'\ue0a0' # U+E0A0 Powerline VCS branch
ROBOT=$'\uf544'  # U+F544 fa-robot

# Extract all fields in one jq call (unit separator to handle empty fields)
IFS=$'\x1f' read -r MODEL DIR PCT COST VIM_MODE DURATION_MS STYLE AGENT < <(
  echo "$input" | jq -r '[
    (.model.display_name // "claude"),
    (.workspace.current_dir // ""),
    ((.context_window.used_percentage // 0) | floor | tostring),
    (.cost.total_cost_usd // 0 | tostring),
    (.vim.mode // ""),
    (.cost.total_duration_ms // 0 | tostring),
    (.output_style.name // "default"),
    (.agent.name // "")
  ] | join("\u001f")'
)

# Git status — cached to avoid lag on large repos
CACHE_DIR_KEY=$(printf '%s' "$DIR" | md5 2>/dev/null || printf '%s' "$DIR" | md5sum 2>/dev/null | cut -d' ' -f1)
CACHE_FILE="/tmp/statusline-git-cache-${CACHE_DIR_KEY}"
CACHE_MAX_AGE=5  # seconds

cache_is_stale() {
    [ ! -f "$CACHE_FILE" ] && return 0
    local age=$(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0) ))
    [ "$age" -gt "$CACHE_MAX_AGE" ]
}

if cache_is_stale; then
    if [ -n "$DIR" ] && git -C "$DIR" rev-parse --git-dir > /dev/null 2>&1; then
        BRANCH_NAME=$(git -C "$DIR" branch --show-current 2>/dev/null)
        STAGED=$(git -C "$DIR" diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
        MODIFIED=$(git -C "$DIR" diff --numstat 2>/dev/null | wc -l | tr -d ' ')
        printf '1|%s|%s|%s\n' "$BRANCH_NAME" "$STAGED" "$MODIFIED" > "$CACHE_FILE"
    else
        printf '0|||\n' > "$CACHE_FILE"
    fi
fi

IFS='|' read -r IS_GIT BRANCH_NAME STAGED MODIFIED < "$CACHE_FILE"

# Context bar — heavy for filled, light for empty
FILLED=$((PCT * 10 / 100))
EMPTY=$((10 - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR="${FG_BASE}$(awk -v n="$FILLED" 'BEGIN{for(i=0;i<n;i++) printf "━"}')"
[ "$EMPTY"  -gt 0 ] && BAR="${BAR}${FG_DIM}$(awk -v n="$EMPTY"  'BEGIN{for(i=0;i<n;i++) printf "─"}')"
BAR="${BAR}${FG_BASE}"

# Cost and duration formatting
COST_FMT=$(awk -v c="$COST" 'BEGIN { printf "$%.2f\n", c+0 }')
DURATION_FMT=$(awk -v ms="$DURATION_MS" 'BEGIN {
    s = int(ms / 1000); m = int(s / 60); h = int(m / 60)
    if (h > 0) printf "%dh%dm", h, m % 60
    else        printf "%dm", m
}')

# Determine git bg/fg colors based on dirty state
GIT_BG="$BG_GREEN"; GIT_FG="$FG_GREEN"
if [ "${IS_GIT:-0}" = "1" ]; then
    GIT_DIRTY=0
    [ "${STAGED:-0}" -gt 0 ] || [ "${MODIFIED:-0}" -gt 0 ] && GIT_DIRTY=1
    [ "$GIT_DIRTY" = "1" ] && GIT_BG="$BG_YELLOW" && GIT_FG="$FG_YELLOW"
fi

# Determine vim bg/fg colors
VIM_BG="$BG_GREEN"; VIM_FG="$FG_GREEN"
[ "$VIM_MODE" = "NORMAL" ] && VIM_BG="$BG_YELLOW" && VIM_FG="$FG_YELLOW"

# Build line — LAST_FG tracks the previous segment's bg color for the right cap
LINE="${RESET}${FG_BLUE}${CAP_L}${BG_BLUE}${FG_BASE}${BOLD} ${CHIP} ${MODEL} "
LAST_FG="$FG_BLUE"

if [ "${IS_GIT:-0}" = "1" ]; then
    GIT_TEXT="${BRANCH} ${BRANCH_NAME}"
    [ "${STAGED:-0}"   -gt 0 ] && GIT_TEXT="${GIT_TEXT} +${STAGED}"
    [ "${MODIFIED:-0}" -gt 0 ] && GIT_TEXT="${GIT_TEXT} ~${MODIFIED}"
    LINE="${LINE}${LAST_FG}${GIT_BG}${SEP}${FG_BASE}${BOLD} ${GIT_TEXT} "
    LAST_FG="$GIT_FG"
fi

# Context + cost + duration segment
LINE="${LINE}${LAST_FG}${BG_MAUVE}${SEP}${FG_BASE}${BOLD} ${BAR} ${PCT}% ${COST_FMT} ${DURATION_FMT} "
LAST_FG="$FG_MAUVE"

# Output style — teal pill, hidden when default
if [ -n "$STYLE" ] && [ "$STYLE" != "default" ]; then
    LINE="${LINE}${LAST_FG}${BG_TEAL}${SEP}${FG_BASE}${BOLD} ${STYLE} "
    LAST_FG="$FG_TEAL"
fi

# Agent — peach pill, only shown when --agent flag is active
if [ -n "$AGENT" ]; then
    LINE="${LINE}${LAST_FG}${BG_PEACH}${SEP}${FG_BASE}${BOLD} ${ROBOT} ${AGENT} "
    LAST_FG="$FG_PEACH"
fi

# Vim mode — only shown when vim mode is enabled
if [ -n "$VIM_MODE" ]; then
    LINE="${LINE}${LAST_FG}${VIM_BG}${SEP}${FG_BASE}${BOLD} ${VIM_MODE} "
    LAST_FG="$VIM_FG"
fi

# Right rounded cap
LINE="${LINE}${RESET}${LAST_FG}${CAP_R}${RESET}"

printf '%s\n' "$LINE"