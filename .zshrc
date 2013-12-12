ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kreeger"
CURRENT_USER="bkreeger"
export EDITOR='subl -w'
plugins=(osx rbenv git rails bundler virtualenvwrapper zsh-syntax-highlighting)
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
export PATH=$HOME/bin:/usr/local/bin:/usr/local/share/npm/bin:$HOME/Code/android-sdk/tools:$HOME/Code/android-sdk/platform-tools:$PATH
source $ZSH/oh-my-zsh.sh
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
# workon default
