# git in terminal

git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

markup_git_branch() {
  if [[ "x$1" = "x" ]]; then
    echo -e "\033[1;31m[-]\033[0;0m"
  else
    if [[ $(git status 2> /dev/null | tail -n1) = 'nothing to commit, working tree clean' ]]; then
      echo -e '\033[1;32m['"$1"']\033[0;0m'
    else
      echo -e '\033[1;31m['"$1"'*]\033[0;0m'
    fi
  fi
}

export PS1="\033[1;32m\u@\h\033[0;0m:\033[1;34m\w\033[0;0m \$(markup_git_branch \$(git_branch))\n$ "