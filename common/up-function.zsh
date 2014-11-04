# Changes to the ancestor directory with the given name. For example:
#
#	$ pwd
#	/home/user/foo/bar/baz
#	$ up foo
#	$ pwd
#	/home/user/foo
#
# Also outputs the ancestor's path, for use in other commands. For example:
#
#	$ pwd
#	/home/user/foo/bar/baz
#	$ mv quuz.txt $(up foo)
#
function up {
	local pathParts
	pathParts=("${(s|/|)$(pwd)}")  # split pwd by slash
	local target=""
	local part
	for part in $pathParts; do
		target=$target/$part
		if [[ $part == $1 ]]; then
			echo $target
			cd $target
			break
		fi
	done
}
