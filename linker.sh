#! /bin/bash

# changedir into script path
cd `dirname $0`

echo "=== Symlinking dotfiles"
for src in $(find ~/dotfiles -name '.*' -d 1)
do 
	file=`basename $src`

	if [[ $file != '.git' ]]
	then
		echo "Symlinking $file from $src"
		ln -Ffs $src ~/
	fi
done

# Resume previous directory
cd -
