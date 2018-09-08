ZSH=$HOME/.dot/submodules/oh-my-zsh

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"           # use case-sensitive completion

#DISABLE_AUTO_UPDATE="true"     # disable weekly auto-update checks
#DISABLE_LS_COLORS="true"       # disable colors in ls
#DISABLE_AUTO_TITLE="true"      # disable autosetting terminal title

COMPLETION_WAITING_DOTS="true"  # display red dots while waiting for completion

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn pip per-directory-history)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source ~/.dot/common.sh
source ~/.dot/up-function.zsh
source ~/.dot/notify-function.zsh

# If on a remote machine, show the hostname in the prompt
if [ "$SSH_CLIENT" ]; then
	local machine_name=$(hostname -s)
	local colored_hostname="%(?:%{$fg_bold[green]${machine_name}%}:%{$fg_bold[red]${machine_name}%}%s)"
	export PROMPT="${colored_hostname} $PROMPT"
else
	# Show the time right-aligned at the prompt (causes problems over SSH)
	export RPROMPT="%F{yellow}%T%f"
fi

