autoload -Uz compinit
compinit

fpath=(~/.zsh/zsh-completions/src $fpath)

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(fnm completions --shell zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ll="exa -la"
alias vi="nvim"
alias vim="nvim"
alias cat="bat"
alias code="code -enable-features=UseOzonePlatform -ozone-platform=wayland"

export EDITOR="nvim"
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export PATH="$PATH:$HOME/.go/go/bin"
export PATH="$PATH:$GOBIN"
export PATH="$PATH:/opt/nvim-linux64/bin"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
