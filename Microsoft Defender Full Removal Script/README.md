# Complete Microsoft Defender Uninstall Tool

## Overview

This repository contains a bash script designed to completely uninstall Microsoft Defender for Endpoint from macOS systems. The script stops all related services, removes the Microsoft Defender application, and deletes all associated files and configurations to ensure a thorough cleanup. This tool is ideal for IT administrators and users who need to fully remove Microsoft Defender for Endpoint from their systems.

## Script: `uninstall_defender.sh`

### Features:
- **Service Termination**: Stops all Microsoft Defender-related services before proceeding with the uninstallation.
- **Application Removal**: Deletes the Microsoft Defender app from the system.
- **File and Configuration Cleanup**: Removes all related files, directories, and configurations to prevent any residuals from being left behind.
- **Complete Uninstallation**: Ensures that no traces of Microsoft Defender remain on the system.

### Usage Instructions:
1. **Download the Script**: Download the `uninstall_defender.sh` script from this repository.
2. **Make the Script Executable**:
   ```bash
   chmod +x uninstall_defender.sh
   ```
3. **Run the Script**:
   ```bash
   ./uninstall_defender.sh
   ```
4. **Monitor the Process**: The script will display messages as it stops services, removes the application, and cleans up related files.
5. **Restart System**: After the script completes, you will be prompted to restart your system to finalize the uninstallation.

### Important Notes:
- This script is designed specifically for macOS systems. The process may differ for Windows or Linux environments.
- Before running the script, ensure that Microsoft Defender is no longer required for system security.
- It is recommended to back up important data before proceeding with the uninstallation.

## Why Use This Script?
- **Resolve Software Conflicts**: Uninstalling Microsoft Defender can prevent conflicts with other security solutions or system processes.
- **Free Up Resources**: Removing Microsoft Defender can free up system resources, leading to improved overall performance.
- **Security and Privacy**: Ensures that no remnants of the security tool remain, protecting your system from potential vulnerabilities.

## License

This script is licensed under the MIT License. You are free to use, modify, and distribute this script as per the terms of the license.

## Legal Disclaimer

The contents of this repository, including all scripts and associated documentation, are provided solely for internal, educational, and non-commercial use. By accessing or using this repository, you agree not to use, modify, or distribute any of the included materials for commercial purposes without express permission from the repository owner. Unauthorized use or distribution of this repository's contents may be subject to legal action. Contact the repository owner for any permissions or licensing inquiries.

## Contact

For any questions or support, please contact:
- **Mohammed AlAttar**
- Email: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- LinkedIn: [Mohammed AlAttar](https://www.linkedin.com/in/mohammed-z-alattar/)

Feel free to fork this repository, submit issues, or contribute to the script to improve its functionality.
