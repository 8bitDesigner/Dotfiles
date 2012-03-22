# Set up path info (add MacPorts support)
paths="
$HOME/.gem/ruby/1.8/bin
$HOME/usr/bin
$HOME/usr/lib/python2.7/site-packages
/opt/local/bin
/opt/local/sbin
/usr/local/bin"

if [[ -d "$HOME/Sites/ci" ]]; then
	paths="$HOME/Sites/ci/bin $paths"
fi


export PATH="`echo $paths | tr ' ' ':'`:$PATH"


# Help files are helpful
mans="
$HOME/usr/share/man
/opt/local/man
/opt/local/share/man
/usr/local/share"

export MANPATH="`echo $mans | tr ' ' ':'`:$MANPATH"


export JS_CMD=`which node`
export NODE_PATH="/Users/paul/usr/lib"
export N_PREFIX="$HOME/usr/node_versions"
