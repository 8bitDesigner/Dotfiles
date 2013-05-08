# Set up path info (add MacPorts support)
paths="
$HOME/usr/bin
$HOME/usr/lib/python2.7/site-packages
/opt/local/bin
/opt/local/sbin
/usr/local/bin"

export PATH="`echo $paths | tr ' ' ':'`:$PATH"

# Help files are helpful
mans="
$HOME/usr/share/man
/opt/local/man
/opt/local/share/man
/usr/local/share"

export MANPATH="`echo $mans | tr ' ' ':'`:$MANPATH"
export JS_CMD=`which node`
