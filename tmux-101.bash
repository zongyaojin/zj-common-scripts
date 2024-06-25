#!/bin/bash
set -e

path=$(realpath "$0")
file=$(basename "$path")
session="zjin"

echo -e "
In terminal, or tmux command mode:
  [list sessions]  tmux ls
  [kill server]    tmux kill-server OR tmux kill-ser
  [show info]      tmux info
  [listing]        tmux list-keys/commands/panes/windows

  [attach session]               tmux a OR tmux a -t \$session_name
  [kill current/last session]    tmux kill-session OR tmux kill-ses
  [kill all but current session] tmux kill-ses -a
  [kill target session]          tmux kill-ses -t \$session_name
  [kill window]                  tmux kill-window OR tmux kill-win

In tmux:
  [navigation]        C-b | arrows
  [adjust apne size]  C-b-arrows
  [copy, scrolling]   C-b | [
  [command mode]      C-b | :
  [show shortcuts]    C-b | ?
  [detach]            C-b | d
  [exit a mode]       Esc OR q

  [show pane id]      C-b | q
  [go to pane]        C-b | q | 0..9
  [kill pane]         C-d OR C-b | x

  [list windows]      C-b | w
  [go to window]      C-b | w | 0..9
  [close window]      C-b | &
  [rename window]     C-b | ,

  [split vertical]    C-b | \"
  [split horizontal]  C-b | %
"

if command -v "terminator" >/dev/null 2>&1; then
  attach_session_command='terminator --execute "tmux attach-session -t $session; exec bash"'
else
  attach_session_command='gnome-terminal -- bash -c "tmux attach-session -t $session; exec bash"'
fi

if tmux has-session -t "$session" 2>/dev/null; then
  echo "[$file] tmux session [$session] exists, attching it..."
  eval $attach_session_command
  exit 0
fi

tmux new-session -d -s $session &
echo "[$file] created and detached tmux session [$session]"
eval $attach_session_command

window=win
tmux rename-window $window

tmux split-window -h
tmux split-window -v -t $session:$window.0
tmux split-window -v -t $session:$window.2

tmux select-pane -t $session:$window.0

tmux send-keys -t $session:$window.0 "echo 'in $session:$window.0'" Enter
sleep 1

tmux send-keys -t $session:$window.1 "echo 'in $session:$window.1'" Enter
tmux send-keys -t $session:$window.1 "echo 'also in $session:$window.1'" Enter
sleep 1

tmux send-keys -t $session:$window.2 "echo 'in $session:$window.2'" Enter
tmux send-keys -t $session:$window.2 "echo 'also in $session:$window.2'" Enter
sleep 1

tmux send-keys -t $session:$window.3 "echo 'in $session:$window.3'" Enter
