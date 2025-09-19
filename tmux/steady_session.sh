#!/usr/bin/env bash


PROJ="steady"

start_tmux

tmux has-session -t $PROJ 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $PROJ -n "editor"

	tmux send-keys -t $PROJ:editor "cd ~/Documents/steadyfarm/" C-m
	tmux send-keys -t $PROJ:editor "nv" C-m

	tmux new-window  -t $PROJ -n "git"
	tmux send-keys -t $PROJ:git "cd ~/Documents/steadyfarm/" C-m
	tmux send-keys -t $PROJ:git "lg" C-m

	tmux new-window  -t $PROJ -n "servers"
	tmux split-window -v -t $PROJ:server
	tmux split-window -h -t $PROJ:server.1
	tmux send-keys -t "$PROJ:server.1" 'sudo dockerd'
	tmux send-keys -t "$PROJ:server.2" 'sudo supabase status'
	tmux send-keys -t "$PROJ:server.3" 'spacetime start' 


	tmux select-window -t $PROJ:editor
fi

tmux attach-session -t $PROJ
