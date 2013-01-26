function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo `basename $VIRTUAL_ENV`' '
}

export VIRTUAL_ENV_DISABLE_PROMPT='1'

case `uname` in
    Darwin)
    RPROMPT='%{$fg[green]%}$(virtualenv_info)%{$reset_color%}% %{$fg[red]%}$(rbenv version | sed -e "s/ (set.*$//")%{$reset_color%}'
    ;;
esac

PROMPT='%{$fg_bold[green]%}%p%{$fg[cyan]%}%c%{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
