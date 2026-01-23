#!/bin/bash

echo "======================================="
echo " ZarkosX External Cleaner + Auto Start "
echo "======================================="

# Space before (KB)
BEFORE=$(df --output=avail / | tail -1)

echo "[*] Space before cleaning:"
df -h /

echo "---------------------------------------"
echo "[*] Cleaning system & user caches..."
echo "---------------------------------------"

# System cleanup
sudo apt clean
sudo apt autoclean
sudo apt autoremove -y

# User caches (SAFE)
rm -rf ~/.cache/*
rm -rf ~/.gradle
rm -rf ~/.emu
rm -rf ~/.npm/_cacache/*
rm -rf ~/.npm/_logs/*
rm -rf ~/.npm/*
rm -rf ~/.local/share/Trash/*
rm -rf ~/.config/Code/Cache/*
rm -rf ~/.config/Code/CachedData/*
rm -rf ~/.config/Code/Crashpad/*
rm -rf ~/.config/google-chrome/*Cache*
rm -rf ~/logs/*
rm -rf ~/temp/*
rm -rf ~/tmp/*

# VS Code server cache
rm -rf ~/.vscode-server/data/CachedData/*
rm -rf ~/.vscode-server/extensions/.obsolete

# Temp
sudo rm -rf /tmp/*

# Docker cleanup (NO volumes)
docker system prune -a -f

echo "---------------------------------------"
echo "[*] Cleaning finished"
echo "---------------------------------------"

# Space after (KB)
AFTER=$(df --output=avail / | tail -1)

# Calculate freed space
FREED=$((AFTER - BEFORE))
FREED_GB=$(awk "BEGIN {printf \"%.2f\", $FREED/1024/1024}")

echo "[*] Space after cleaning:"
df -h /

echo "======================================="
echo " Freed Space: ${FREED_GB} GB ✅"
echo "======================================="

# Start Windows container
echo "[*] Starting Windows container..."
sudo docker-compose -f windows-ZarkosX-win10.yml up
