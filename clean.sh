#!/bin/bash

echo "=============================="
echo " Codespaces Safe Cleaner"
echo "=============================="

# Get available space before (in KB)
BEFORE=$(df --output=avail / | tail -1)

echo "[*] Cleaning system caches..."

sudo apt clean
sudo apt autoclean
sudo apt autoremove -y

# User cache cleanup
rm -rf ~/.cache/*
rm -rf ~/.gradle
rm -rf ~/.emu
rm -rf ~/logs/*
rm -rf ~/temp/*
rm -rf ~/tmp/*
rm -rf ~/.local/share/Trash/*
rm -rf ~/.npm/_cacache/*
rm -rf ~/.npm/_logs/*
rm -rf ~/.npm/*
rm -rf ~/.config/Code/Cache/*
rm -rf ~/.config/Code/CachedData/*
rm -rf ~/.config/Code/Crashpad/*
rm -rf ~/.config/google-chrome/*Cache*

# VS Code server
rm -rf ~/.vscode-server/data/CachedData/*
rm -rf ~/.vscode-server/extensions/.obsolete

# Temp
sudo rm -rf /tmp/*

# Docker (safe – no volumes)
docker system prune -a -f

# Get available space after (in KB)
AFTER=$(df --output=avail / | tail -1)

# Calculate freed space
FREED=$((AFTER - BEFORE))

# Convert to GB
FREED_GB=$(awk "BEGIN {printf \"%.2f\", $FREED/1024/1024}")

echo "=============================="
echo " Cleaning Finished ✅"
echo " Freed Space: ${FREED_GB} GB"
echo "=============================="
