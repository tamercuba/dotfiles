export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="bira"
plugins=(git zsh-autosuggestions )
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH


# Stow config
export DOT=$HOME/projetos/dotfiles

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export XCOMPOSEFILE=~/.XCompose
export PATH="$HOME/.local/bin:$PATH"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ]; then
    export DISPLAY=$(ps aux | grep "Xorg :" | grep -v grep | grep $USER | awk '{print $12}' | head -1)
fi

