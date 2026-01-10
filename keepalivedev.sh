#!/bin/bash

SESSION="keepalive"

# Update & install tmux if not installed
if ! command -v tmux &> /dev/null; then
    sudo apt update && sudo apt install tmux -y
fi

# Check if tmux session already exists
if tmux has-session -t $SESSION 2>/dev/null; then
    echo "Tmux session '$SESSION' already running."
    exit 0
fi

# Create tmux session and run keepalive loop
tmux new-session -d -s $SESSION "while true; do echo \"\$(date): KEEPING CODESPACE ALIVE!\"; sleep 29m; done"

echo "✅ Keepalive tmux session started successfully!"
echo "➡️ To attach later: tmux attach -t keepalive"
