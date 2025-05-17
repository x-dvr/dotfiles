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

alias ls="exa"
alias ll="exa -la"
alias vi="helix"
alias vim="helix"
alias cat="bat"
alias code="codium"
alias hx="helix"
alias z="zoxide"

export EDITOR="helix"
export GOPATH="$HOME/.go"
export GOBIN="$HOME/.go/bin"
export PATH="$PATH:$HOME/.go/go/bin"
export PATH="$PATH:$GOBIN"
export PATH="$PATH:$HOME/bin"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^H' backward-kill-word
bindkey '5~' kill-word
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^U'      kill-region

go_audit() {
  go mod verify
  go vet ./...
  go run honnef.co/go/tools/cmd/staticcheck@latest -checks=all,-ST1000,-U1000 ./...
  go run golang.org/x/vuln/cmd/govulncheck@latest -show verbose ./...
  go test -race -buildvcs -vet=off ./...
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(ssh-agent -s)" > /dev/null

fastfetch
