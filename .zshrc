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
alias code="codium"

export EDITOR="nvim"
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export PATH="$PATH:$HOME/.go/go/bin"
export PATH="$PATH:$GOBIN"
export PATH="$PATH:/opt/nvim-linux64/bin"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^H' backward-kill-word
bindkey '5~' kill-word

go_audit() {
  go mod verify
  go vet ./...
  go run honnef.co/go/tools/cmd/staticcheck@latest -checks=all,-ST1000,-U1000 ./...
  go run golang.org/x/vuln/cmd/govulncheck@latest -show verbose ./...
  go test -race -buildvcs -vet=off ./...
}

eval "$(ssh-agent -s)" > /dev/null

fastfetch