export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git fzf extract python rust golang )

source $ZSH/oh-my-zsh.sh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Instalar
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#
export HISTCONTROL=ignoreboth
export HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

export PATH="$HOME/.local/bin:$PATH:/opt/homebrew/bin:/bin:/usr/bin"


# Datomic
export PATH="$HOME/.datomic/datomic-pro-1.0.7394/:$HOME/.datomic/datomic-pro-1.0.7394/bin:$PATH"

export PYTHONBREAKPOINT=ipdb.set_trace
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

export JAVA_HOME="/usr/bin/java"

export GOPATH=$HOME/projetos/go
export GOROOT="$(brew --prefix golang)/libexec"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}
autoload -U add-zsh-hook
add-zsh-hook precmd load_nvm

eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ "$(hostname -s)" == "tamer" && -f ~/.company.zshrc ]]; then
  source ~/.company.zshrc
fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
