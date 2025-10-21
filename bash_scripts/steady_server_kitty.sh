#!/usr/bin/env bash
# steady_server_kitty.sh
# Kitty version of your tmux script

PROJ="steady_server"
SOCKET="unix:/tmp/kitty"

# Start a new kitty instance if socket doesn't exist
if [ ! -S /tmp/kitty ]; then
  echo "Starting Kitty with socket..."
  kitty --detach --title "$PROJ" --listen-on $SOCKET bash -c "sleep infinity"
  sleep 1
fi

# --- DB TAB ---
kitty @ --to $SOCKET launch --type=tab --title "DB" bash -c "sudo dockerd; exec bash"
sleep 0.3
kitty @ --to $SOCKET launch --type=window --match tab-title:DB --location=vsplit bash -c "su && supabase status; exec bash"

# --- MP_SERVER TAB ---
kitty @ --to $SOCKET launch --type=tab --title "MP_SERVER" bash -c "spacetime start; exec bash"
sleep 0.3
kitty @ --to $SOCKET launch --type=window --match tab-title:MP_SERVER --location=vsplit bash -c "steady && cd MPServer && spacetime logs steady -f; exec bash"

# Focus the first tab again
kitty @ --to $SOCKET focus-tab --match tab-title:DB
