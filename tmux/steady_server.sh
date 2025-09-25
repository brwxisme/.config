#!/usr/bin/env bash


PROJ="steady_server"

start_tmux

tmux has-session -t $PROJ 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $PROJ -n "DB"

	tmux split-window -v -t $PROJ:DB
	tmux send-keys -t $PROJ:DB.2 "su && supabase status" C-m
	tmux send-keys -t $PROJ:DB.1 "sudo dockerd" C-m

	tmux new-window  -t $PROJ -n "MP_SERVER"
	tmux split-window -v -t $PROJ:MP_SERVER
	tmux send-keys -t $PROJ:MP_SERVER.1 "spacetime start" C-m
	sleep 1
	tmux send-keys -t $PROJ:MP_SERVER.2 "spacetime logs steady -f" C-m

	tmux select-window -t $PROJ:DB.1
	tmux select-pane -t $PROJ:DB.1
	# tmux select-window -t $PROJ:MP_SERVER
fi

tmux attach-session -t $PROJ
