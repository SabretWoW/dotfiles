function _git_branch_name
  echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (git status -s --ignore-submodules=dirty ^/dev/null)
end

function fish_prompt
    if test "$PWD" != "$HOME"
        set path (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        set path '~'
    end

    printf '%s%s ' (set_color 72fffc) $path

    # Print git tag or branch
    if [ (_git_branch_name) ]
        printf '%s(%s%s%s)%s ' (set_color 7169fd) (set_color f96664) (_git_branch_name) (set_color 7169fd) (set_color normal)
        if [ (_is_git_dirty) ]
            printf '%s✗%s ' (set_color ffff99) (set_color normal)
        end
    end
    set_color normal
end
