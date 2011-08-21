# Set up path info (add MacPorts support)
my_bin="$HOME/usr/bin"
macports_bin="/opt/local/bin:/opt/local/sbin"
export PATH="$my_bin:$macports_bin:$PATH"

# Help files are helpful
my_man="$HOME/usr/share/man"
macports_man="/opt/local/man:/opt/local/share/man"
export MANPATH="$my_man:$macports_man:$MANPATH"

export PYTHONPATH="$HOME/usr/lib/python2.7/site-packages"

export JS_CMD=`which node`
export NODE_PATH="/Users/paul/usr/lib"
export N_PREFIX="$HOME/usr/node_versions"

if [ -e /usr/share/terminfo/*/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi

