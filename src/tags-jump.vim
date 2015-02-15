#!/usr/bin/env vim

function! TagCommand()
  return substitute('awk _!/^!/ { print \$1 }_ ', '_', "'", 'g')
              \ . join(tagfiles(), ' ')
endfunction

command! FZFTag call fzf#run({
\   'source'     : TagCommand(),
\   'sink'       : 'tag',
\   })
