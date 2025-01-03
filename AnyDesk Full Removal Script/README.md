# Complete AnyDesk Removal Script

## Overview

This repository contains a bash script designed to completely remove AnyDesk from macOS systems. The script terminates running AnyDesk processes, deletes the AnyDesk application, and removes all related files and directories to ensure that no remnants remain on the system. This script is ideal for IT professionals and users who need a clean and thorough removal of AnyDesk.

## Script: `uninstall_anydesk.sh`

### Features:
- **Process Termination**: Automatically terminates any running AnyDesk processes.
- **Application Removal**: Deletes the AnyDesk application from the system.
- **File Cleanup**: Removes related files, including preferences, logs, caches, and other supporting files.
- **Complete Uninstallation**: Ensures that all traces of AnyDesk are removed from the system.

### Usage Instructions:
1. **Download the Script**: Download the `uninstall_anydesk.sh` script from this repository.
2. **Make the Script Executable**:
   ```bash
   chmod +x uninstall_anydesk.sh
   ```
3. **Run the Script**:
   ```bash
   ./uninstall_anydesk.sh
   ```
4. **Monitor the Process**: The script will display messages as it terminates processes, removes the application, and cleans up related files.
5. **Verify Removal**: After the script completes, you can manually check that no AnyDesk files remain on your system by inspecting the relevant directories.

### Important Notes:
- This script is designed specifically for macOS systems. For Windows or Linux, the process will differ.
- Before running the script, ensure that AnyDesk is not required for any ongoing operations.
- It is recommended to back up important data before proceeding with the uninstallation.

## Why Use This Script?
- **Resolve Software Conflicts**: Uninstalling AnyDesk can prevent conflicts with other remote desktop solutions or system processes.
- **Free Up Resources**: Removing AnyDesk can free up system resources, leading to better overall performance.
- **Security and Privacy**: Ensures that no remnants of the remote access tool remain, protecting your system from unauthorized access.

## License

This script is licensed under the MIT License. You are free to use, modify, and distribute this script as per the terms of the license.

## Legal Disclaimer
The contents of this repository, including all scripts and associated documentation, are provided solely for internal, educational, and non-commercial use. By accessing or using this repository, you agree not to use, modify, or distribute any of the included materials for commercial purposes without express permission from the repository owner. Unauthorized use or distribution of this repository's contents may be subject to legal action. Contact the repository owner for any permissions or licensing inquiries.

## Contact

For any questions or support, please contact:
- **Mohammed Alattar**
- Email: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- LinkedIn: [Mohammed AlAttar](https://www.linkedin.com/in/mohammed-z-alattar/)

Feel free to fork this repository, submit issues, or contribute to the script to improve its functionality.
