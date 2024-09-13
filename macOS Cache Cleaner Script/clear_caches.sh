#!/bin/bash

# Define the cache directory
CACHE_DIR="$HOME/Library/Caches"

# Check if the directory exists
if [ -d "$CACHE_DIR" ]; then
    echo "The cache directory is located at: $CACHE_DIR"
    echo "This action will delete all files inside the Caches directory."
    read -p "Are you sure you want to proceed? (y/n): " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        # Delete the files inside the Caches directory
        rm -rf "$CACHE_DIR"/*
        echo "All files inside $CACHE_DIR have been deleted."
        
        # Prompt to ask if the user wants to restart the system
        read -p "Would you like to restart the system now? (y/n): " restart
        if [[ "$restart" =~ ^[Yy]$ ]]; then
            sudo shutdown -r now
        else
            echo "System restart skipped."
        fi
    else
        echo "Operation canceled."
    fi
else
    echo "The cache directory does not exist. No action taken."
fi
