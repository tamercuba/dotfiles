export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bira"
plugins=(git python rust golang )
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

eval "$(uv generate-shell-completion zsh)"

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
