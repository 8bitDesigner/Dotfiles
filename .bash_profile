# =================================================
# Import in non-interactive commands
# =================================================

source ~/.bashrc

# =================================================
# Init RVM
# =================================================
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# =================================================
# Colors
# =================================================

# First set up our terminal as xterm
if [[ -n `find /usr/share/terminfo -name 'xterm-256color'` ]]; then
  export TERM='xterm-256color'
elif [[ -n `find /lib/terminfo -name 'xterm-256color'` ]]; then
  export TERM='xterm-256color'
elif [[ -n $TMUX ]]; then
  export TERM='screen-256color'
else
  export TERM='xterm-color'
fi

# =================================================
# Default bash stuff
# =================================================

export EDITOR=nvim

if [[ "$OSTYPE" =~ 'darwin' ]]; then
  export BROWSER=/usr/bin/open
fi

# Sane history
# http://blog.sanctum.geek.nz/better-bash-history/
# https://github.com/mrzool/bash-sensible/
shopt -s histappend                      # Append to .bash_history - don't rewrite
shopt -s cmdhist                         # Save multi-line commands as one command
unset HISTFILESIZE                       # Record fugging everything
HISTSIZE=1000000
HISTCONTROL='erasedups:ignoreboth'       # Ignore dupe commands, and commands starting with a space
HISTIGNORE='ls:bg:fg:history:jobs'       # Ignore the output of common commands
PROMPT_COMMAND='history -a'              # Record history after each command, not terminal close

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1


# Less > More
export PAGER="less"
export LESS="-niSRFX"
  # -n supppres line numbers
  # i  search ignores case
  # S  scroll horizontally
  # R  interpret color escape sequences
  # F  quit if one screen
  # X  no init

# Commandline customisation
function current { branch=`git current`; if [[ -n $branch ]]; then echo " ($branch)"; fi }
export PS1='\[\033[00;32m\]\h\[\033[01;34m\] \w\[\033[00;35m\]$(current)\n\[\033[01;34m\]\$\[\033[00m\] '

# Autocompletion for fs-cli
source "/usr/local/lib/node_modules/fs-cli/fs-completion.bash"

# Homebrew autocompletion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Autocomplete for SSH hostnames
complete -W "$(echo $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | sort -u | grep -v "\["))" ssh


# =================================================
# Aliases
# =================================================

# Default options
alias ls='ls -G'      # always use colors
alias la='ls -alsG'   # List all, with colors
alias ll='la'
alias vim='nvim -p'   # Vim should open multiple files in tabs
alias vi='nvim -p'
alias pine='alpine'
alias g='git'

if [[ "$OSTYPE" =~ 'darwin' ]]; then
  alias tree='tree -C'  # Tree with colors
fi


# =================================================
# TMUX Nonsense
# =================================================

# Show running tmux sessions
if [[ -n "`which tmux`" && -n `tmux ls 2> /dev/null` ]]
then
  echo ":: Running tmux sessions ::"
  tmux ls 2> /dev/null
fi

# Set the name of the current tmux window to the current
# directory if in a git repo, otherwise restore the automatic-rename option
function muxwin {
  repo=$(git rev-parse --show-toplevel 2> /dev/null)
  if [[ -n "$TMUX" && -n "$repo" ]]; then
    tmux rename-window $(basename $(git rev-parse --show-toplevel))
  elif [[ -n "$TMUX" ]]; then
    tmux set-window-option -q automatic-rename on
  fi
}

export PROMPT_COMMAND="$PROMPT_COMMAND && muxwin"
