export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git autoenv zsh-autosuggestions python rust golang pyenv-lazy)
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$HOME/.local/bin:$PATH:/opt/homebrew/bin:/bin:/usr/bin"

# Python Config
export PYTHONBREAKPOINT=ipdb.set_trace
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

# Java Config
export JAVA_HOME="/usr/bin/java"

# Golang Config
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

alias docker=podman

eval "$(/opt/homebrew/bin/brew shellenv)"
