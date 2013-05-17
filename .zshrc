ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kreeger"
CURRENT_USER="bkreeger"
export EDITOR='subl -w'
plugins=(osx rbenv git rails3 bundler virtualenvwrapper)
export PATH=/opt/boxen/rbenv/bin:/opt/boxen/bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH
source $ZSH/oh-my-zsh.sh
zstyle ':completion:*:*:git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
# workon default
