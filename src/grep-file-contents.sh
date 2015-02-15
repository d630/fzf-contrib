#!/usr/bin/env sh

grep --line-buffered --color=never -r "" * | fzf
