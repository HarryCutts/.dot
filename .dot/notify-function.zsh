# Runs a command and displays a notification when it finishes or fails.
# 
# Example usage:
#
#	$ notify apt install cowsay
#	$ notify "apt install cowsay && cowsay moo"
#
# TODO: make compatible with macOS
#
function notify {
	eval "$@"
	local returnCode=$?
	if [ "$returnCode" = 0 ]; then
		notify-send --icon=emblem-ok-symbolic "Command finished" "$*"
	else
		notify-send --icon=emblem-important-symbolic "Command failed" "$*"
	fi
}
