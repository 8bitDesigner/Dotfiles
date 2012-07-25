#! /bin/bash

me=`basename $0`
dir=`dirname $0`

cd $dir

echo "=== Symlinking dotfiles"
for src in $(find $PWD -maxdepth 1)
do
	file=`basename $src`

	if [[
		$file != '.git'                  &&
		$file != '.'                     &&
		$file != '..'                    &&
		$file != 'osx.sh'                &&
		$file != 'QLStephen.qlgenerator' &&
		$file != $me
	]]
	then
		echo "Symlinking $file from $src"
		ln -Ffs $src ~/
	fi
done

# Configure OSX settings
echo "=== Setting OSX options"
./osx.sh $dir

# Resume previous directory
cd - > /dev/null

echo "=== Done!"
