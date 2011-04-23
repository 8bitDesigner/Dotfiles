#! /bin/bash

echo "=== Symlinking dotfiles"
for src in $(find ~/Dropbox/Prefs -name '.*' -d 1)
do 
	file=`basename $src`

	echo "Symlinking $file"
	ln -Ffs $src ~/
done
