# Set up path info (add MacPorts support)
paths="
./node_modules/.bin
$HOME/.rvm/bin
$HOME/Library/Python/2.7/bin
/usr/local/sbin
/usr/local/bin"

export PATH="`echo $paths | tr ' ' ':'`:$PATH"

# Help files are helpful
mans="
$HOME/usr/share/man
/usr/local/share"

export NODE_REPL_HISTORY_FILE=$HOME/.node_repl_history

export MANPATH="`echo $mans | tr ' ' ':'`:$MANPATH"
export JS_CMD=`which node`

source $HOME/.env
