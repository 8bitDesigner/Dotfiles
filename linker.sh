#! /bin/bash

me=`basename $0`
dir=`dirname $0`

cd $dir

echo "=== Symlinking dotfiles"
for src in $(find $PWD -d 1)
do
	file=`basename $src`

	if [[
		$file != '.git' &&
		$file != '.'    &&
		$file != '..'   &&
		$file != $me
	]]
	then
		echo "Symlinking $file from $src"
		ln -Ffs $src ~/
	fi
done

# Resume previous directory
cd -
