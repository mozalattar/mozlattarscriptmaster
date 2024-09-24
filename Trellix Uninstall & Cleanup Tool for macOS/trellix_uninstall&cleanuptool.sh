#!/bin/sh

# Set the password
PASSWORD="YOURPASSWORD"

# Function to run sudo commands with password
run_with_sudo() {
    echo "$PASSWORD" | sudo -S "$@"
}

trellix_installed=false

# Uninstall McAfee agent
if [ -f /Library/McAfee/agent/scripts/uninstall.sh ]; then
    echo "Uninstalling McAfee agent..."
    run_with_sudo /Library/McAfee/agent/scripts/uninstall.sh
    echo "McAfee agent uninstalled successfully."
    trellix_installed=true
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
    trellix_installed=true
else
    echo "Uninstall command for specific modules not found at /usr/local/McAfee/uninstall"
fi

# Uninstall McAfee files
if [ -f /usr/local/McAfee/UninstallCleanUp ]; then
    echo "Running UninstallCleanUp..."
    run_with_sudo /usr/local/McAfee/UninstallCleanUp
    echo "UninstallCleanUp executed successfully."
    trellix_installed=true
else
    echo "UninstallCleanUp script not found at /usr/local/McAfee/UninstallCleanUp"
fi

# Manually delete leftover files and directories
echo "Deleting leftover files and directories..."

# Applications
if [ -d /Applications/TrellixSystemExtensions.app ]; then
    run_with_sudo rm -rf /Applications/TrellixSystemExtensions.app
    trellix_installed=true
fi

if [ -d /Applications/Trellix\ Endpoint\ Security\ for\ Mac.app ]; then
    run_with_sudo rm -rf /Applications/Trellix\ Endpoint\ Security\ for\ Mac.app
    trellix_installed=true
fi

# Library directories
if [ -d /Library/Application\ Support/McAfee ]; then
    run_with_sudo rm -rf /Library/Application\ Support/McAfee
    trellix_installed=true
fi

# Library LaunchDaemons
for plist in /Library/LaunchDaemons/com.mcafee.agentMonitor.helper.plist     /Library/LaunchDaemons/com.mcafee.ssm.Eupdate.plist     /Library/LaunchDaemons/com.mcafee.ssm.ScanFactory.plist     /Library/LaunchDaemons/com.mcafee.ssm.ScanManager.plist     /Library/LaunchDaemons/com.mcafee.virusscan.fmpd.plist     /Library/LaunchDaemons/com.trellix.dlp.XPCBroker.plist     /Library/LaunchDaemons/com.mcafee.atp.plist     /Library/LaunchDaemons/com.mcafee.ssm.antimalware.plist     /Library/LaunchDaemons/com.mcafee.ssm.dlp.plist     /Library/LaunchDaemons/com.mcafee.ssm.StatefulFirewall.plist; do
    if [ -f "$plist" ]; then
        run_with_sudo rm -f "$plist"
        trellix_installed=true
    fi
done

# Library Preferences
for plist in /Library/Preferences/com.mcafee.atp.plist     /Library/Preferences/com.mcafee.ssm.antimalware.plist     /Library/Preferences/com.mcafee.ssm.dlp.plist     /Library/Preferences/com.mcafee.ssm.StatefulFirewall.plist; do
    if [ -f "$plist" ]; then
        run_with_sudo rm -f "$plist"
        trellix_installed=true
    fi
done

# Library LaunchAgents
for plist in /Library/LaunchAgents/com.mcafee.McAfeeSafariHost.plist     /Library/LaunchAgents/com.mcafee.menulet.plist     /Library/LaunchAgents/com.mcafee.reporter.plist     /Library/LaunchAgents/com.mcafee.uninstall.SystemExtension.plist; do
    if [ -f "$plist" ]; then
        run_with_sudo rm -f "$plist"
        trellix_installed=true
    fi
done

# Private directories
if [ -d /private/etc/ma.d ]; then
    run_with_sudo rm -rf /private/etc/ma.d
    trellix_installed=true
fi

# System directories
if [ -d /usr/local/Quarantine ]; then
    run_with_sudo rm -rf /usr/local/Quarantine
    trellix_installed=true
fi

if [ -d /usr/local/McAfee ]; then
    run_with_sudo rm -rf /usr/local/McAfee
    trellix_installed=true
fi

# Etc directories
if [ -d /etc/cma.d ]; then
    run_with_sudo rm -rf /etc/cma.d
    trellix_installed=true
fi

if [ -d /etc/ma.d ]; then
    run_with_sudo rm -rf /etc/ma.d
    trellix_installed=true
fi

# Optional
if [ -d /opt/McAfee ]; then
    run_with_sudo rm -rf /opt/McAfee
    trellix_installed=true
fi

echo "Cleanup completed."

# Check if Trellix was installed and uninstalled
if [ "$trellix_installed" = true ]; then
    # Notify the user Trellix has been removed and prompt for restart
    USER_CHOICE=$(osascript -e 'display dialog "Trellix has been successfully removed. It is recommended to restart your system. Would you like to restart now?" buttons {"Yes", "No"} default button "Yes"')

    # Check the user's response
    if [[ "$USER_CHOICE" == "button returned:Yes" ]]; then
        # User clicked Yes, proceed with restart
        run_with_sudo shutdown -r now
    else
        # User clicked No, just display a reminder
        echo "Please remember to restart your system later to complete the cleanup process."
    fi
else
    echo "Trellix was not detected. No restart is required."
fi
