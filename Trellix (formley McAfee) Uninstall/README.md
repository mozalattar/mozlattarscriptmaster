# Trellix (formerly McAfee) Uninstall

## Overview

This repository contains a bash script designed to fully uninstall Trellix (formerly McAfee) software from macOS systems. The script removes the McAfee agent, specific Endpoint Security modules, and any associated files and directories to ensure a complete cleanup. This tool is particularly useful for IT administrators who need to manage multiple macOS systems.

## Script: `trellix-uninstall.sh`

### Features:
- **Automated Removal**: The script automates the uninstallation process for the McAfee agent and various Endpoint Security modules.
- **Complete Cleanup**: It deletes leftover files and directories that may remain after the standard uninstallation process.
- **User Prompt**: The script prompts the user for their Trellix password, ensuring security while running commands that require elevated privileges.
- **System Restart**: The script offers the option to restart the system after the cleanup process to ensure all changes take effect.

### Usage Instructions:
1. **Download the Script**: Download the `trellix-uninstall.sh` script from this repository.
2. **Make the Script Executable**:
   ```bash
   chmod +x trellix-uninstall.sh
   ```
3. **Run the Script**:
   ```bash
   ./trellix-uninstall.sh
   ```
4. **Enter Password**: When prompted, enter your Trellix (formerly McAfee) password. The script will proceed to uninstall the software and perform a cleanup.
5. **Restart (Optional)**: After the cleanup, you will be prompted to restart your system. It is recommended to restart to complete the uninstallation process.

### Important Notes:
- Ensure that you have administrative privileges on the macOS system where you run this script.
- The script is intended for use in environments where Trellix (formerly McAfee) software needs to be completely removed from macOS systems.
- Before running the script, it’s advisable to back up any critical data.

## License

This script is licensed under the MIT License. You are free to use, modify, and distribute this script as per the terms of the license.

## Contact

For any questions or support, please contact:
- **Mohammed Alattar**
- Email: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- LinkedIn: [Mohammed Z. Alattar](https://www.linkedin.com/in/mohammed-z-alattar/)

Feel free to fork this repository, submit issues, or contribute to the script to improve its functionality.
