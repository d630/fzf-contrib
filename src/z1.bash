#!/usr/bin/env bash

unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf)"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed -n 's/^[ 0-9.,]*//p' | fzf -q $_last_z_args)"
}
# Since z is not very optimal located on a qwerty keyboard I have these aliased as j and jj

alias j=z
alias jj=zz
