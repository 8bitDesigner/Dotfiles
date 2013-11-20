# Set up path info (add MacPorts support)
paths="
$HOME/.rvm/bin
$HOME/usr/bin
$HOME/usr/lib/python2.7/site-packages
/usr/local/heroku/bin
/usr/local/bin"

export PATH="`echo $paths | tr ' ' ':'`:$PATH"

# Help files are helpful
mans="
$HOME/usr/share/man
/usr/local/share"

export MANPATH="`echo $mans | tr ' ' ':'`:$MANPATH"
export JS_CMD=`which node`
