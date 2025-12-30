#!/bin/bash

LOG_FILE="keepalive.log"

echo "🚀 Keep Alive Script Started..." | tee -a $LOG_FILE

# لما تدوس CTRL+C
trap "echo '🛑 Script Stopped' | tee -a $LOG_FILE; exit" SIGINT SIGTERM

while true
do
  echo "✅ Alive | $(date)" | tee -a $LOG_FILE
  
  # حركة بسيطة عشان يبقى في activity
  ls > /dev/null 2>&1
  
  sleep 30
done
