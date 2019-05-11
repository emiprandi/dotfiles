# -------------------------------------------------------
# PATH
# -------------------------------------------------------

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

# -------------------------------------------------------
# PROMPT
# -------------------------------------------------------

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
WHITE="\033[1;37m"
BOLD=""
RESET="\033[m"

export RED
export YELLOW
export GREEN
export BLUE
export PURPLE
export WHITE
export BOLD
export RESET

parse_git_dirty () {
  [[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo " 💩"
}
parse_git_branch () {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

export PS1="\[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" · \")\[$YELLOW\]\$(parse_git_branch)\[$BLUE\]\n❯ \[$RESET\]"

# -------------------------------------------------------
# EXTRA
# -------------------------------------------------------
. aliases
