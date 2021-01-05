##############
## Packages ##
##############
use epm

# Various command completions
epm:install &silent-if-installed github.com/zzamboni/elvish-completions
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh

# Bang-Bang (Bash-style history with !!, !$, etc.)
epm:install &silent-if-installed github.com/zzamboni/elvish-modules
use github.com/zzamboni/elvish-modules/bang-bang

# Powerline theme (requires fonts, e.g. from fonts-powerline Debian package)
epm:install &silent-if-installed github.com/muesli/elvish-libs
use github.com/muesli/elvish-libs/theme/powerline
powerline:prompt-segments = [
  dir
  virtualenv
  git-branch
  git-ahead
  git-behind
  git-staged
  git-dirty
  git-untracked
  newline
  timestamp
  arrow
]
if (not-eq $E:SSH_CLIENT '') {
  powerline:prompt-segments = [host-short $@powerline:prompt-segments]
}
powerline:prompt-segments = [newline $@powerline:prompt-segments]

# `up` and `anc`
use anc
edit:completion:arg-completer[anc] = $anc:anc-completer
edit:completion:arg-completer[up] = $anc:anc-completer
anc~ = $anc:anc~
up~ = $anc:up~

#######################
## Other completions ##
#######################

edit:completion:arg-completer[sudo] = $edit:complete-sudo~
edit:completion:arg-completer[exec] = $edit:complete-sudo~

#############
## Aliases ##
#############

-exports- = [&]

# Creates an alias while keeping whatever completion exists for the target
# command.
fn alias-with-comp [name cmd @args]{
  -exports-[$name'~'] = [@rest]{ (external $cmd) $@args $@rest }
  if (has-key $edit:completion:arg-completer $cmd) {
    edit:completion:arg-completer[$name] = [_ @rest]{
      $edit:completion:arg-completer[$cmd] $cmd $@args $@rest
    }
  }
}

alias-with-comp ga git add
alias-with-comp gc git commit
alias-with-comp gca git commit -v -a
alias-with-comp gco git checkout
alias-with-comp gd git diff
alias-with-comp gdw git diff --word-diff
alias-with-comp gs git status

alias-with-comp ls ls --color=auto
alias-with-comp nv nvim
alias-with-comp o xdg-open

##########
## Misc ##
##########

E:EDITOR = nvim
