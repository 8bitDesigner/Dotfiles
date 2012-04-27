# =================================================
# Import in non-interactive commands
# =================================================

source ~/.bashrc


# =================================================
# Colors
# =================================================

# First set up our terminal as xterm
if [[ -n `find /usr/share/terminfo -name 'xterm-256color'` ]]; then
	export TERM='xterm-256color'
elif [[ -n `find /lib/terminfo -name 'xterm-256color'` ]]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi

# Now, if we're in a tmux session, reconfigure the term now
if [[ -n $TMUX ]]; then
	export TERM='screen-256color'
fi


# =================================================
# Default bash stuff
# =================================================

# nano sucks
export EDITOR=/opt/local/bin/vim
export VIM_APP_DIR=/Applications/MacPorts/

# Sane history -- http://blog.sanctum.geek.nz/better-bash-history/
shopt -s histappend                      # Append to .bash_history - don't rewrite
unset HISTFILESIZE                       # Record fugging everything
HISTSIZE=1000000
HISTCONTROL=ignoreboth                   # Ignore dupe commands, and commands starting with a space
HISTIGNORE='ls:bg:fg:history:jobs'       # Ignore the output of common commands
PROMPT_COMMAND='history -a; history -n'  # Record history after each command, not terminal close

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1

# Less > More
export PAGER="less"
export LESS="-niSRFX"
	# n supppres line numbers
	# i search ignores case
	# S scroll horizontally
	# R interpret color escape sequences
	# F quit if one screen
	# X no init

# Commandline customisation
function current { branch=`git current`; if [[ -n $branch ]]; then echo " ($branch)"; fi }
export PS1='\[\033[00;32m\]\h\[\033[01;34m\] \w\[\033[00;35m\]$(current)\[\033[01;34m\] \$\[\033[00m\] '
export MYSQL_PS1="(\u@\h):[\d]> "

# Bash completion via MacPorts
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

# Autocomplete for SSH hostnames
complete -W "$(echo $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | sort -u | grep -v "\["))" ssh


# =================================================
# Aliases
# =================================================

# Default options
alias ls='ls -G'      # always use colors
alias la='ls -alsG'   # List all, with colors
alias gitk='gitx'     # gitx > a separate X server
alias port='port -uc'
alias tree='tree -C'  # Tree with colors
alias vim='vim -p'    # Vim should open multiple files in tabs
alias vi='vim -p'
alias pine='alpine'
alias g='git'

# Normalising port version numbers
alias mysql='mysql5'
alias mysqladmin='mysqladmin5'

# Fake Programs
alias apachectl='sudo /opt/local/apache2/bin/apachectl'
alias apache_restart='sudo port unload apache2 && sudo port load apache2'
alias mysqlstart='sudo -v && sudo mysqld_safe5 &'
alias mysqlstop='mysqladmin -u root -p shutdown'


# =================================================
# Remote shell logins
# =================================================

mdns_name="141530781.members.btmm.icloud.com."
macbook="WC-Macbook.$mdns_name"
macpro="WC-Macpro.$mdns_name"
work="BM-PSweeney.$mdns_name"


# =================================================
# Login messages
# =================================================

# Stupid Unix tricks
echo ""
fortune -a 50% all 50% $HOME/fortune 2> /dev/null
echo ""

# Show running tmux sessions
if [[ -z "$TMUX" && -n "`which tmux`" ]]
then
	echo ":: Running tmux sessions ::"
	tmux ls 2> /dev/null
fi
