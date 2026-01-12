#!/bin/bash

echo "🔄 Playit.gg Script is starting..."

# Download playit agent
wget https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64

# Make it executable
chmod +x playit-linux-amd64

# Run the agent
./playit-linux-amd64

echo "✅ Playit.gg Script finished."
