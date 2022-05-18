##############
## Packages ##
##############
use epm

# Various command completions
epm:install &silent-if-installed github.com/zzamboni/elvish-completions
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/dd
use github.com/zzamboni/elvish-completions/evemu
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh

epm:install &silent-if-installed github.com/HarryCutts/elvish-chromium-dev
use github.com/HarryCutts/elvish-chromium-dev/gclient

# Bang-Bang (Bash-style history with !!, !$, etc.)
epm:install &silent-if-installed github.com/zzamboni/elvish-modules
use github.com/zzamboni/elvish-modules/bang-bang

# Powerline theme. Requires fonts:
# * on Debian, install the fonts-powerline package
# * for the ChromeOS Secure Shell extension, add the relevant font entries to
#   the "Text font family" option (e.g. `"Cousine", "Powerline For Cousine"`;
#   https://chromium.googlesource.com/apps/libapps/+/HEAD/nassh/doc/fonts.md)
epm:install &silent-if-installed github.com/muesli/elvish-libs
use github.com/muesli/elvish-libs/theme/powerline
set powerline:prompt-segments = [
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
  set powerline:prompt-segments = [host-short $@powerline:prompt-segments]
}
set powerline:prompt-segments = [newline $@powerline:prompt-segments]

# `up` and `anc`
use anc
set edit:completion:arg-completer[anc] = $anc:anc-completer
set edit:completion:arg-completer[up] = $anc:anc-completer
var anc~ = $anc:anc~
var up~ = $anc:up~

#######################
## Other completions ##
#######################

set edit:completion:arg-completer[sudo] = $edit:complete-sudo~
set edit:completion:arg-completer[exec] = $edit:complete-sudo~

#############
## Aliases ##
#############

# Creates an alias while keeping whatever completion exists for the target
# command.
fn alias-with-comp {|name cmd @args|
  edit:add-var $name'~' {|@rest| (external $cmd) $@args $@rest }
  if (has-key $edit:completion:arg-completer $cmd) {
    set edit:completion:arg-completer[$name] = {|_ @rest|
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

set E:EDITOR = nvim

# Add Chromium depot tools to the path, if installed in the usual location.
use path
if (path:is-dir ~/dev/depot_tools) {
  set paths = [$@paths ~/dev/depot_tools]
}
