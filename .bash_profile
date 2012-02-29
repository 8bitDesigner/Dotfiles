# =================================================
# Import in non-interactive commands
# =================================================

source ~/.bashrc


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

# Normalising port version numbers 
alias mysql='mysql5'
alias mysqladmin='mysqladmin5'

# Fake Programs
alias apachectl='sudo /opt/local/apache2/bin/apachectl'
alias mysqlstart='sudo -v && sudo mysqld_safe5 &'
alias mysqlstop='mysqladmin -u root -p shutdown'


# =================================================
# Remote shell logins
# =================================================

alias dreamhost='ssh wildcard99@8-bitdesign.com'

mdns_name="141530781.members.btmm.icloud.com."
macbook="WC-Macbook.$mdns_name"
macpro="WC-Macpro.$mdns_name"


# =================================================
# Default term stuff
# =================================================

# nano sucks
export EDITOR=/opt/local/bin/vim
export VIM_APP_DIR=/Applications/MacPorts/

# Sane history
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# Colors
export TERM=xterm-color
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
export PS1='\[\033[00;32m\]\h\[\033[01;34m\] \w\[\033[00;35m\]$(git current)\[\033[01;34m\] \$\[\033[00m\] '
export MYSQL_PS1="(\u@\h):[\d]> "

# Bash completion via MacPorts
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

# Autocomplete for SSH hostnames
complete -W "$(echo $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | sort -u | grep -v "\["))" ssh
