# =================================================
# Import in non-interactive commands
# =================================================

source ~/.bashrc


# =================================================
# Aliases
# =================================================

# Default options
alias ls='ls -G'
alias la='ls -alsG'
alias gitk='gitx'
alias gitl='git log'
alias lynx='links'
alias tidy='tidy -cim -wrap 0 --indent-spaces 4 --tab-size 8 --tidy-mark no --show-warnings 0'
alias jsl='jsl -nofilelisting -nologo -conf ~/.jslrc'
alias port='port -uc'
alias tree='tree -C'
alias vim='vim -p'
alias xterm='xterm -r -geometry 90x23 -fa Andale\ Mono -fs 13'
alias synergy='synergys --config /opt/local/etc/synergy/synergy.conf'

# Normalising port version numbers 
alias mysql='mysql5'
alias mysqladmin='mysqladmin5'
alias python='python2.5'

# Fake Programs
alias apachectl='sudo /opt/local/apache2/bin/apachectl'
alias mysqlstart='sudo -v && sudo mysqld_safe5 &'
alias mysqlstop='mysqladmin -u root -p shutdown'
alias markdown='perl ~/usr/bin/Markdown.pl'
alias mini='java -jar ~/usr/bin/yuicompressor-2.4.2.jar' 
alias minijs='java -jar ~/usr/bin/yuicompressor-2.4.2.jar --type js' 
alias minicss='java -jar ~/usr/bin/yuicompressor-2.4.2.jar --type css'
alias node='n use `n --latest`'

# Readline wrappers
alias js='rlwrap js'
alias phpa='rlwrap php -a'
alias java='rlwrap java'

# rsync music: 
# rsync -rzuv --exclude-from=/Users/paul/Documents/OSXPoo --exclude=iTunes* ~/Music/ 192.168.1.210:~/Music/


# =================================================
# Remote shell logins
# =================================================

alias dreamhost='ssh wildcard99@8-bitdesign.com'
alias app1jm1='ssh psweeney@app1v-fe.jm.dev1.gnmedia.net'
alias deploy='ssh psweeney@deploy.lax3.gnmedia.net'


# =================================================
# Git utility functions
# =================================================

function bash_git_branch {
	git branch 2> /dev/null | grep \* | python -c "print ' ('+raw_input()[2:]+')'" 2> /dev/null
}

function prod_merge {
	branch=`bash_git_branch | grep -Po "[^\(\)\s]*"`
	lastCommit=`git log -1 | cut -d' ' -f 2 | head -n1`

	if [ $branch != 'prod' ]; then
		git svn rebase
		git svn dcommit
		git co prod
	fi

	git svn rebase
	git cp $lastCommit
	git svn dcommit

	if [ $branch != 'prod' ]; then
		git co $branch
	fi
}


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

export PAGER="less"
export LESS="-niSRFX"
	# n supppres line numbers
	# i search ignores case
	# S scroll horizontally
	# R interpret color escape sequences
	# F quit if one screen
	# X no init


# Commandline customisation
export PS1='\[\033[00;32m\]\h\[\033[01;34m\] \w\[\033[00;35m\]$(bash_git_branch)\[\033[01;34m\] \$\[\033[00m\] '
export MYSQL_PS1="(\u@\h):[\d]> "


# Bash completion via MacPorts
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi


# Autocomplete for SSH hostnames
complete -W "$(echo $(cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | sort -u | grep -v "\["))" ssh
