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
export PATH="$HOME/.local/bin:$HOME/.emacs.d/bin/:$PATH"

if [ -z "$DISPLAY" ]; then
    DISPLAY=$(ps aux | grep "Xorg :" | grep -v grep | grep $USER | awk '{for(i=1;i<=NF;i++) if($i ~ /^:/) print $i}' | head -1)
    export DISPLAY=${DISPLAY:-:0}
fi
