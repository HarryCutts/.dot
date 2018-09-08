export EDITOR=vim

host_specific_path_file="$HOME/.dot/host-specific-path.sh"
if [ -e $host_specific_path_file ]; then
	source $host_specific_path_file
fi
unset host_specific_path_file

source ~/.dot/shell-aliases.sh

# Gitignore.io fetcher
function gitignore() { curl -L -s https://www.gitignore.io/api/$@ ;}
