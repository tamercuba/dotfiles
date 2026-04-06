# oh-my-zsh
export ZSH_THEME="bira"
export DISABLE_MAGIC_FUNCTIONS="true"
export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"

plugins=(git fzf extract)

export ZSH="$HOME/.nix-profile/share/oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"

if [[ -f ~/.secrets.zshrc ]]; then
  source ~/.secrets.zshrc
fi

source "$HOME/.nix-profile/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/.nix-profile/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.nix-profile/share/zsh-history-substring-search/zsh-history-substring-search.zsh"

eval "$(fzf --zsh)"

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

export PATH="$HOME/.local/bin:$PATH"

export LESS_TERMCAP_md="$(tput bold 2>/dev/null; tput setaf 2 2>/dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2>/dev/null)"

alias img="kitten icat"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
