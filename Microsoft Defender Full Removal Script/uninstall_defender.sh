
#!/bin/bash

# Stop Microsoft Defender services
echo "Stopping Microsoft Defender services..."
sudo launchctl unload /Library/LaunchDaemons/com.microsoft.wdav.plist
sudo launchctl unload /Library/LaunchDaemons/com.microsoft.wdav.uninstall.plist

# Unload system extensions related to Microsoft Defender
echo "Unloading system extensions..."
sudo systemextensionsctl uninstall com.microsoft.wdav

# Remove Microsoft Defender app
DEFENDER_APP_PATH="/Applications/Microsoft Defender.app"
if [ -d "$DEFENDER_APP_PATH" ]; then
    echo "Removing Microsoft Defender app..."
    sudo rm -rf "$DEFENDER_APP_PATH"
fi

# Remove related files and directories
echo "Removing related files and directories..."
sudo rm -rf /Library/Application\ Support/Microsoft/Defender
sudo rm -rf /Library/Application\ Support/Microsoft/sense
sudo rm -rf /Library/Preferences/com.microsoft.wdav.*
sudo rm -rf /Library/LaunchDaemons/com.microsoft.wdav.*
sudo rm -rf /Library/Managed\ Preferences/com.microsoft.wdav.*

# Uninstall using the uninstall script if available
UNINSTALL_SCRIPT="/Library/Application Support/Microsoft/Defender/uninstall/install_helper"
if [ -f "$UNINSTALL_SCRIPT" ]; then
    echo "Running the uninstall script..."
    sudo "$UNINSTALL_SCRIPT" execute --path '/Library/Application Support/Microsoft/Defender/uninstall/uninstall' --args --post-uninstall-hook
fi

# Clean up any residual files and folders
echo "Cleaning up residual files..."
sudo rm -rf /Library/Application\ Support/Microsoft
sudo rm -rf /Library/Logs/Microsoft/Defender
sudo rm -rf /Library/Preferences/com.microsoft.*
sudo rm -rf /Library/LaunchAgents/com.microsoft.wdav.*

# Prompt to restart the system
read -p "Cleanup completed. It is recommended to restart your system. Would you like to restart now? (y/n): " choice
case "$choice" in 
  y|Y ) sudo shutdown -r now;;
  n|N ) echo "Please remember to restart your system later to complete the cleanup process.";;
  * ) echo "Invalid input. Please remember to restart your system later to complete the cleanup process.";;
esac

echo "Uninstallation of Microsoft Defender for Endpoint is complete."

exit 0
