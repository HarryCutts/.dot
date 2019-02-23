# Changes to the ancestor directory with the given name. For example:
#
#	$ pwd
#	/home/user/foo/bar/baz
#	$ up foo
#	/home/user/foo
#	$ pwd
#	/home/user/foo
#
# Subdirectories of the ancestor can also be specified. For example:
#
#	$ pwd
#	/home/user/foo/bar/baz
#	$ up foo/bees
#	/home/user/foo/bees
#
# Also outputs the target path, for use in other commands. For example:
#
#	$ pwd
#	/home/user/foo/bar/baz
#	$ mv quuz.txt $(up foo)
#
up() {
	local pathParts=()
	local target="${1%%/*}"  # split $1 by the first slash
	local tail="${1#*/}"
	local targetPath=""

	# ಠ_ಠ
	local readDashASwitch
	if [[ $ZSH_NAME ]]; then
		readDashASwitch='-A'
	else
		readDashASwitch='-a'
	fi

	IFS='/' read -r $readDashASwitch pathParts <<< $(pwd)

	local part
	for part in ${pathParts[@]}; do
		targetPath=$targetPath/$part
		if [[ $part == $target ]]; then
			break
		fi
	done

	if [[ $1 == */* ]]; then
		targetPath=$targetPath/$tail
	fi
	echo $targetPath
	cd $targetPath
}
