# Command Line
alias ..="cd .."
alias ...="cd ../.."
alias p="cd ~/Projects"

alias l="ls -lFG"
alias la="ls -laFG"

# GIT
alias gs="git status"
alias gaa="git add -A"
alias gd="git diff"
alias gca="git commit --amend"
alias gp="git pull --prune"
alias gb="git branch"
alias gcm="git checkout master"
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gco="git checkout"

ga() {
  if [ -n "$1" ]
  then
    git add "$@"
  else
    echo "Please include some filenames"
  fi
}

gc() {
  if [ -n "$1" ]
  then
    git commit -m "$1"
  else
    echo "Please type a commit message"
  fi
}

# Extras
alias server="python -m SimpleHTTPServer"
alias intel="arch -x86_64"

archive() {
  if [ -n "$1" ]
  then
    tar cvf - "$@" | split -b 2000m - "$@".tar.
  else
    echo "Please indicate a file or folder"
  fi
}

unarchive() {
  if [ -n "$1" ]
  then
    cat "$@"* | tar xvf -
  else
    echo "Please indicate the files to unarchive without the auto increment part: for 20211026.tar.aa -> 20211026.tar."
  fi
}

# ENV
path+=('/opt/homebrew/bin')
export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PROMPT
setopt PROMPT_SUBST

parse_node_version () {
  nvm current 2> /dev/null
}
parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo " 🌈"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ | \1$(parse_git_dirty)/"
}

PROMPT="(%F{cyan}$(arch)%f) %B%F{blue}%~%f%b %F{green}⬢ "'$(parse_node_version)'"%f%F{yellow}"'$(parse_git_branch)'"%f ❯ "
