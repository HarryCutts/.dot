use str

var -subshell-env-var = 'ELVISH__IN_ANDROID_PLATFORM_BUILD_ENV'

# $true if this shell is a subshell created by the `lunch` function.
var in-build-env = (has-env $-subshell-env-var)

var build-top = ''
var host-out = ''
var product-out = ''
var target-build-apps = ''
var target-build-type = ''
var target-build-variant = ''
var target-product = ''
var target-release = ''

if $in-build-env {
  set build-top = $E:ANDROID_BUILD_TOP
  set host-out = $E:ANDROID_HOST_OUT
  set product-out = $E:ANDROID_PRODUCT_OUT
  set target-build-apps = $E:TARGET_BUILD_APPS
  set target-build-type = $E:TARGET_BUILD_TYPE
  set target-build-variant = $E:TARGET_BUILD_VARIANT
  set target-product = $E:TARGET_PRODUCT
  set target-release = $E:TARGET_RELEASE
}

fn -quoted-args-list {|args|
  if (== (count $args) 0) {
    put ''
  } else {
    put '"'(str:join '" "' $args)'"'
  }
}

fn -enter-env {|setup-command args|
  # TODO: this doesn't seem to show errors (e.g. missing credentials) in the output
  bash -c '
    source build/envsetup.sh
    '$setup-command' '(-quoted-args-list $args)'
    '$-subshell-env-var'=y exec elvish
  '
}

fn lunch {|@args| -enter-env lunch $args }
fn tapas {|@args| -enter-env tapas $args }
fn banchan {|@args| -enter-env banchan $args }

fn run-in-env {|command @args|
  if (not $in-build-env) { fail "Not in an Android build environment" }
  # TODO: try to silence the normal output of envsetup.sh. I tried adding `|
  # grep --invert-match --extended-regexp "^including " || true`, but that
  # results in "m: command not found" when running ap:m
  bash -c '
    pushd $ANDROID_BUILD_TOP > /dev/null
    source build/envsetup.sh
    popd > /dev/null
    '$command' '(-quoted-args-list $args)''
}

fn m {|@rest| run-in-env m $@rest }

# TODO: if we're in an Androidy environment (see below), create an alias (or
# member of this module's namespace?) for each function from build/envsetup.sh.
# Each alias will run a bash shell (without RC file, probably) that `source`s
# build/envsetup.sh (relative to $E:ANDROID_BUILD_TOP; maybe redirecting its
# debug output to /dev/null), and runs (or execs) the relevant command
