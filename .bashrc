#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias config='/usr/bin/git --git-dir=/home/till/.cfg/ --work-tree=/home/till'
alias config='/usr/bin/git --git-dir=/home/till/.cfg/ --work-tree=/home/till'
alias config='/usr/bin/git --git-dir=/home/till/.cfg/ --work-tree=/home/till'

# Pyenv environment variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Pyenv initialization
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(pyenv init -)"
alias config='/usr/bin/git --git-dir=/home/till/.cfg/ --work-tree=/home/till'
