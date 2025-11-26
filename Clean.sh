#!/bin/bash
rm -rf ~/.gradle
rm -rf ~/.emu
rm -rf ~/.cache/*
rm -rf ~/logs/*
sudo docker system prune -af --volumes
sudo apt autoremove -y
sudo apt clean -y
