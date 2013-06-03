set -x PATH $HOME/.rbenv/bin $HOME/.rbenv/shims /usr/local/bin $PATH
set fish_greeting ''
rbenv rehash >/dev/null ^&1

alias s "subl3"
alias s3 "subl3"
alias s2 "subl"
alias gs "git status"
alias ga "git add"
alias gc "git commit --verbose"
alias gp "git push"
alias gl "git pull"
alias gd "git diff"
alias gai "git add -i"
alias gco "git checkout"
alias gt "git tag"
alias gpt "git push; and git push --tags"
alias rs "rails server"
alias rc "rails console"
alias rsp "rails server puma"
alias fs "foreman start"
alias be "bundle exec"
alias rg "rails generate"
