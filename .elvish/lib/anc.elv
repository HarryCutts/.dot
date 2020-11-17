# Returns the path of the ancestor directory with the given name. For example:
#
#  > pwd
#  ▶ /home/user/foo/bar/baz
#  > anc foo
#  ▶ /home/user/foo
#
# Subdirectories of the ancestor can also be specified. For example:
#
#  > pwd
#  ▶ /home/user/foo/bar/baz
#  > anc foo/bees
#  ▶ /home/user/foo/bees
#
# (anc does not check that such a subdirectory exists, however.)
#
fn anc [arg]{
  use str
  pwd-parts = [(str:split '/' $pwd)]
  arg-parts = [(str:split '/' $arg)]
  dir = $arg-parts[0]
  anc-index = (- (count $pwd-parts) 1)
  while (and (> $anc-index 0) (not-eq $dir $pwd-parts[$anc-index])) {
    anc-index = (- $anc-index 1)
  }
  if (== $anc-index 0) {
    fail "no ancestor named '"$dir"'"
  }
  result = (str:join '/' $pwd-parts[0:(+ $anc-index 1)])
  if (> (count $arg-parts) 0) {
    result = $result'/'(str:join '/' $arg-parts[1:(count $arg-parts)])
  }
  put $result
}

# Like anc, but changes to the returned directory.
fn up [@a]{
  cd (anc $@a)
}

anc-completer = [@cmd]{
  use str
  if (> (count $cmd) 2) { return }
  arg = $cmd[1]
  if (not (str:contains $arg '/')) {
    # We're just looking for ancestors, the simple case.
    put (str:split '/' $pwd)
    return
  }
  # We're descending again from the ancestor.
  # edit:complete-filename returns full paths, which need trimming.
  arg-base = [(str:split '/' $arg)][0]
  prefix = [(str:split $arg-base $pwd)][0]
  echo "prefix is "$prefix
  filter-and-trim = [x]{
    # Directories have completions ending with /
    if (eq $x[stem][-1] '/') {
      put (str:trim-prefix $x[stem] $prefix)
    }
  }
  edit:complete-filename (anc $arg) | each $filter-and-trim
}

edit:completion:arg-completer[anc:anc] = $anc-completer
edit:completion:arg-completer[anc:up] = $anc-completer
