#!/bin/sh

# Set the password of Trellix or McAfee
PASSWORD="YourPassword"

# Function to run sudo commands with password
run_with_sudo() {
    echo "$PASSWORD" | sudo -S "$@"
}

# Uninstall McAfee agent
if [ -f /Library/McAfee/agent/scripts/uninstall.sh ]; then
    echo "Uninstalling McAfee agent..."
    run_with_sudo /Library/McAfee/agent/scripts/uninstall.sh
    echo "McAfee agent uninstalled successfully."
else
    echo "Uninstall script not found at /Library/McAfee/agent/scripts/uninstall.sh"
fi

# Uninstall specific Endpoint Security modules
if [ -f /usr/local/McAfee/uninstall ]; then
    echo "Uninstalling specific Endpoint Security modules..."
    run_with_sudo /usr/local/McAfee/uninstall EPM
    run_with_sudo /usr/local/McAfee/uninstall ATP
    run_with_sudo /usr/local/McAfee/uninstall Firewall
    run_with_sudo /usr/local/McAfee/uninstall ThreatPrevention
    run_with_sudo /usr/local/McAfee/uninstall WebControl
    echo "Specific Endpoint Security modules uninstalled."
else
    echo "Uninstall command for specific modules not found at /usr/local/McAfee/uninstall"
fi

# Uninstall McAfee files
if [ -f /usr/local/McAfee/UninstallCleanUp ]; then
    echo "Running UninstallCleanUp..."
    run_with_sudo /usr/local/McAfee/UninstallCleanUp
    echo "UninstallCleanUp executed successfully."
else
    echo "UninstallCleanUp script not found at /usr/local/McAfee/UninstallCleanUp"
fi

# Manually delete leftover files and directories
echo "Deleting leftover files and directories..."

if [ -d /usr/local/Quarantine ]; then
    run_with_sudo rm -rf /usr/local/Quarantine
fi

if [ -d /private/etc/ma.d ]; then
    run_with_sudo rm -rf /private/etc/ma.d
fi

if [ -d /Applications/TrellixSystemExtensions.app ]; then
    run_with_sudo rm -rf /Applications/TrellixSystemExtensions.app
fi

if [ -d /Applications/Trellix\ Endpoint\ Security\ for\ Mac.app ]; then
    run_with_sudo rm -rf /Applications/Trellix\ Endpoint\ Security\ for\ Mac.app
fi

if [ -d /Library/Application\ Support/McAfee ]; then
    run_with_sudo rm -rf /Library/Application\ Support/McAfee
fi

if [ -d /usr/local/McAfee ]; then
    run_with_sudo rm -rf /usr/local/McAfee
fi

if [ -f /Library/LaunchDaemons/com.mcafee.agentMonitor.helper.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.agentMonitor.helper.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist
fi

if [ -f /Library/LaunchDaemons/com.trellix.dlp.XPCBroker.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.trellix.dlp.XPCBroker.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.atp.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.atp.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.ssm.antimalware.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.ssm.antimalware.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.ssm.dlp.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.ssm.dlp.plist
fi

if [ -f /Library/LaunchDaemons/com.mcafee.ssm.StatefulFirewall.plist ]; then
    run_with_sudo rm -f /Library/LaunchDaemons/com.mcafee.ssm.StatefulFirewall.plist
fi

if [ -d /Library/LaunchAgents/com.mcafee.* ]; then
    run_with_sudo rm -rf /Library/LaunchAgents/com.mcafee.*
fi

if [ -f /Library/Preferences/com.mcafee.atp.plist ]; then
    run_with_sudo rm -f /Library/Preferences/com.mcafee.atp.plist
fi

if [ -f /Library/Preferences/com.mcafee.ssm.antimalware.plist ]; then
    run_with_sudo rm -f /Library/Preferences/com.mcafee.ssm.antimalware.plist
fi

if [ -f /Library/Preferences/com.mcafee.ssm.dlp.plist ]; then
    run_with_sudo rm -f /Library/Preferences/com.mcafee.ssm.dlp.plist
fi

if [ -f /Library/Preferences/com.mcafee.ssm.StatefulFirewall.plist ]; then
    run_with_sudo rm -f /Library/Preferences/com.mcafee.ssm.StatefulFirewall.plist
fi

if [ -d /Library/Preferences/com.mcafee.* ]; then
    run_with_sudo rm -rf /Library/Preferences/com.mcafee.*
fi

if [ -d /etc/cma.d ]; then
    run_with_sudo rm -rf /etc/cma.d
fi

if [ -d /etc/ma.d ]; then
    run_with_sudo rm -rf /etc/ma.d
fi

if [ -d /opt/McAfee ]; then
    run_with_sudo rm -rf /opt/McAfee
fi

echo "Cleanup completed."

# Prompt to restart the system
read -p "Cleanup completed. It is recommended to restart your system. Would you like to restart now? (y/n): " choice
case "$choice" in 
  y|Y ) run_with_sudo shutdown -r now;;
  n|N ) echo "Please remember to restart your system later to complete the cleanup process.";;
  * ) echo "Invalid input. Please remember to restart your system later to complete the cleanup process.";;
esac
