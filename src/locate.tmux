#!/usr/bin/env tmux

# fzf-locate
bind-key -n 'M-l' run "tmux split-window -p 40 'tmux send-keys -t #{pane_id} \"$(locate / | fzf -m | paste -sd\\  -)\"'"
