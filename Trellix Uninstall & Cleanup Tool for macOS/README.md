# Trellix Uninstall & Cleanup Tool for macOS

This repository contains a bash script named `trellix_uninstall&cleanuptool.sh`, designed to automate the uninstallation of Trellix (formerly McAfee) software from macOS devices. It is compatible with Microsoft Intune, allowing for seamless deployment and monitoring across managed devices.

## Features
- Detects the presence of Trellix software.
- Uninstalls McAfee Agent and Endpoint Security modules.
- Cleans up all related files and directories.
- Prompts the user for a system restart upon successful uninstallation.
- Skips the restart prompt if Trellix is not installed.
- Fully compatible with Microsoft Intune for mass deployment.

## Script Details
The script performs the following tasks:

### Uninstallation of McAfee Agent:
If the McAfee agent uninstall script is detected, it will be executed.

### Uninstallation of Specific Endpoint Security Modules:
Uninstalls modules like ThreatPrevention, WebControl, Firewall, and ATP if they are detected.

### File and Directory Cleanup:
Removes Trellix and McAfee-related directories and files in common locations such as:
- `/Applications`
- `/Library/Application Support`
- `/usr/local`
- `/private/etc`
- `/opt`

### Restart Prompt:
If Trellix is successfully uninstalled, the script will prompt the user to restart the system. If Trellix is not detected, the script will skip the restart prompt.

## Prerequisites
- macOS with administrative privileges.
- The script uses `sudo` to remove certain files, so you'll need a valid admin password.
- The script has been tested on macOS with Intune deployment.

## Deployment via Microsoft Intune
This script is fully compatible with Microsoft Intune and can be deployed to managed macOS devices using the following steps:

### 1. Upload the Script:
In Microsoft Intune, navigate to Devices > macOS > Scripts, then upload the script `trellix_uninstall&cleanuptool.sh`.

### 2. Assign the Script:
Assign the script to the required devices or groups.

### 3. Monitoring:
Once deployed, you can monitor the script's execution and success rate through the Intune interface.

## Usage
Open a terminal and run the script:
```bash
./trellix_uninstall&cleanuptool.sh
```
Make sure the script has executable permissions. You can grant them by running:
```bash
chmod +x trellix_uninstall&cleanuptool.sh
```
If Trellix is detected, the uninstallation process will begin automatically, and the user will be prompted to restart.

## Customization
If you need to customize the script (e.g., add more cleanup tasks or change behavior), you can edit the bash script directly. Key areas include:
- **Application Detection**: Add or modify detection for specific Trellix or McAfee components.
- **File Paths**: Modify the paths to match any custom installation locations used in your organization.

## Troubleshooting
- **Permissions**: Ensure you have administrative privileges when running the script.
- **Intune Logs**: If deploying via Intune, check the device's logs to monitor the execution status.
- **Script Logs**: You can add logging commands (`echo`) to the script to help trace its execution if needed.

## License
This script is licensed under the MIT License. You are free to use, modify, and distribute this script as per the terms of the license.

## Contact
For any questions or support, please contact:
- **Mohammed Alattar**
- Email: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- LinkedIn: [Mohammed Z. Alattar](https://www.linkedin.com/in/mohammed-z-alattar/)

Feel free to fork this repository, submit issues, or contribute to the script to improve its functionality.
