function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

source ~/.dot/common.sh
