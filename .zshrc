autoload -Uz compinit
compinit

fpath=(~/.zsh/zsh-completions/src $fpath)

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(fnm completions --shell zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ll="exa -la"
alias vi="nvim"
alias vim="nvim"
alias cat="bat"

export EDITOR="nvim"
export PATH="$PATH:/opt/nvim-linux64/bin"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
