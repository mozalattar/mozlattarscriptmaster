#!/bin/bash

# Function to check if AnyDesk is running and kill it
terminate_anydesk() {
    echo "Terminating AnyDesk processes..."
    pkill -f "AnyDesk"
    sleep 2
}

# Function to remove AnyDesk application
remove_anydesk_app() {
    echo "Removing AnyDesk application..."
    sudo rm -rf /Applications/AnyDesk.app
}

# Function to remove AnyDesk related files
remove_anydesk_files() {
    echo "Removing AnyDesk related files..."

    # Removing AnyDesk preferences and support files
    sudo rm -rf ~/Library/Preferences/com.philandro.anydesk.plist
    sudo rm -rf ~/Library/Application\ Support/AnyDesk
    sudo rm -rf ~/Library/Caches/com.philandro.anydesk
    sudo rm -rf ~/Library/Saved\ Application\ State/com.philandro.anydesk.savedState
    sudo rm -rf ~/Library/Logs/AnyDesk
    sudo rm -rf /Library/Preferences/com.philandro.anydesk.plist
    sudo rm -rf /Library/LaunchDaemons/com.philandro.anydesk.Helper.plist
    sudo rm -rf /Library/Logs/DiagnosticReports/AnyDesk*
    sudo rm -rf /Library/PrivilegedHelperTools/com.philandro.anydesk.Helper
}

# Execute functions
terminate_anydesk
remove_anydesk_app
remove_anydesk_files

echo "AnyDesk has been successfully uninstalled."
