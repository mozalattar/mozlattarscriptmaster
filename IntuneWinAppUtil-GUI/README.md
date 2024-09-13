
# IntuneWinAppUtil GUI

IntuneWinAppUtil GUI is a PowerShell-based graphical interface for the Microsoft Win32 Content Prep Tool (`IntuneWinAppUtil.exe`). This GUI simplifies the process of converting application installation files into the `.intunewin` format for use with Microsoft Intune.

## Features

- **User-Friendly Interface**: Simplifies the packaging process with a graphical interface.
- **Drag-and-Drop**: Supports drag-and-drop functionality for source folders and setup files.
- **Browse Buttons**: Allows users to browse and select the source folder, setup file, and output folder.
- **Automated Packaging**: Automates the command-line usage of the Microsoft Win32 Content Prep Tool.

## Prerequisites

- **IntuneWinAppUtil.exe**: Download the official Microsoft Win32 Content Prep Tool from the [Microsoft GitHub Repository](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool).

## Installation

1. **Download the Files**:
   - Clone or download this repository to your local machine.
   - Download the `IntuneWinAppUtil.exe` from the Microsoft repository.

2. **Setup**:
   - Place the `IntuneWinAppUtil.exe` in the same directory as the `IntuneWinAppUtilGUI.ps1` script.

## Usage

1. **Run the Script**:
   - Right-click on `IntuneWinAppUtilGUI.ps1` and select "Run with PowerShell".

2. **Using the GUI**:
   - **Source Folder**: Click "Browse..." to select the folder containing your source files.
   - **Setup File**: Click "Browse..." to select the executable file (e.g., `setup.exe`) that you wish to package.
   - **Output Folder**: Click "Browse..." to select the folder where the output `.intunewin` file will be saved.
   - Click "Convert" to package the application.

3. **Screenshots**:

   - **Running the Script**:
     ![Run with PowerShell]([https://github.com/YourRepo/PathToImage/run_with_powershell.png](https://github.com/mozalattar/mozlattarscriptmaster/blob/main/IntuneWinAppUtil-GUI/Running%20the%20Script.png))

   - **GUI Interface**:
     ![GUI Interface]([https://github.com/YourRepo/PathToImage/gui_interface.png](https://github.com/mozalattar/mozlattarscriptmaster/blob/main/IntuneWinAppUtil-GUI/GUI%20Interface.png))

## Notes

- Ensure that the `IntuneWinAppUtil.exe` and the `IntuneWinAppUtilGUI.ps1` script are in the same directory.
- The tool requires PowerShell to be run with appropriate execution policies.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Disclaimer

This project is not affiliated with or endorsed by Microsoft. It is a personal project designed to provide a user-friendly interface for the official Microsoft Win32 Content Prep Tool.

## Contact

For any questions or support, please contact:
- **Mohammed Alattar**
- Email: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- LinkedIn: [Mohammed Z. Alattar](https://www.linkedin.com/in/mohammed-z-alattar/)

Feel free to fork this repository, submit issues, or contribute to the script to improve its functionality.
