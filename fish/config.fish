set -x PATH $HOME/.rbenv/bin $HOME/.rbenv/shims /usr/local/bin $PATH
set fish_greeting ''
rbenv rehash >/dev/null ^&1

alias gs "git status"
alias ga "git add"
alias gc "git commit"
alias gp "git push"
alias gl "git pull"
alias gai "git add -i"
alias gco "git checkout"
alias gt "git tag"
alias gpt "git push; and git push --tags"

