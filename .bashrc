export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec

# Set up path info (add Homebrew support)
paths="
./node_modules/.bin
$GOPATH/bin
$GOROOT/bin
$HOME/.rvm/bin
/usr/local/sbin
/usr/local/opt/python/libexec/bin
/usr/local/bin"

export PATH="`echo $paths | tr ' ' ':'`:$PATH"

# Help files are helpful
mans="
$HOME/usr/share/man
/usr/local/share"

export MANPATH="`echo $mans | tr ' ' ':'`:$MANPATH"
export JS_CMD=`which node`
