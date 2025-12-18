# IntuneWinAppUtil GUI

IntuneWinAppUtil GUI is a PowerShell-based graphical interface for the Microsoft Win32 Content Prep Tool (`IntuneWinAppUtil.exe`). This GUI simplifies the process of converting application installation files into the `.intunewin` format for use with Microsoft Intune.

## Features

- **User-Friendly Interface**: Simplifies the packaging process with a graphical interface.
- **Drag-and-Drop**: Supports drag-and-drop functionality for source folders and setup files.
- **Browse Buttons**: Allows users to browse and select the source folder, setup file, and output folder.
- **Automated Packaging**: Automates the command-line usage of the Microsoft Win32 Content Prep Tool.

## Prerequisites

- **IntuneWinAppUtil.exe**: Download the official Microsoft Win32 Content Prep Tool from the [Microsoft GitHub Repository](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool).
- **Windows PowerShell 5.1** (recommended for GUI stability).

## Installation

1. **Create a Folder**:
   - Create a folder and name it **IntuneGUI**
   - Example:
     ```
     C:\IntuneGUI
     ```

2. **Download the Files**:
   - Clone or download this repository.
   - Download `IntuneWinAppUtil.exe` from the Microsoft repository.

3. **Setup**:
   - Drag & drop the following files into `C:\IntuneGUI`:
     - `IntuneWinAppUtilGUI.ps1`
     - `IntuneWinAppUtil.exe`

## Usage

### Run from PowerShell (Recommended)

1. Open **PowerShell**.
2. Navigate to the folder:
   ```powershell
   cd "C:\IntuneGUI"
   ```
3. Run the script:
   ```powershell
   .\IntuneWinAppUtilGUI.ps1
   ```

> **Note:** PowerShell requires `.\` to run scripts from the current directory.

### Right-Click Run

- Right-click on `IntuneWinAppUtilGUI.ps1`
- Select **Run with PowerShell**

### Execution Policy (if blocked)

If PowerShell blocks the script, run once:
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### PowerShell 7 / GUI Not Opening

If the GUI does not open (common on PowerShell 7), run explicitly with Windows PowerShell and STA mode:
```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -STA -File ".\IntuneWinAppUtilGUI.ps1"
```

## Using the GUI

- **Source Folder**: Select the folder containing all installer files.
- **Setup File**: Select the installer file **located inside the Source Folder** (e.g., `setup.exe`).
- **Output Folder**: Select the destination folder for the `.intunewin` file.
- Click **Convert** to package the application.

> **Important:** The setup file must be located inside the Source Folder. This is a requirement of Microsoft’s `IntuneWinAppUtil.exe`.

## Screenshots

- **Running the Script**:
  ![Run with PowerShell](https://raw.githubusercontent.com/mozalattar/mozlattarscriptmaster/main/IntuneWinAppUtil-GUI/Running%20the%20Script.png)

- **GUI Interface**:
  ![GUI Interface](https://raw.githubusercontent.com/mozalattar/mozlattarscriptmaster/main/IntuneWinAppUtil-GUI/GUI%20Interface.png)

## Notes

- Ensure that `IntuneWinAppUtil.exe` and the `IntuneWinAppUtilGUI.ps1` script are in the same directory.
- The setup file must reside inside the selected source folder.
- Use Windows PowerShell 5.1 for best WinForms compatibility.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Disclaimer

This project is not affiliated with or endorsed by Microsoft. It is a personal project designed to provide a user-friendly interface for the official Microsoft Win32 Content Prep Tool.

## Legal Disclaimer

The contents of this repository, including all scripts and associated documentation, are provided solely for internal, educational, and non-commercial use. By accessing or using this repository, you agree not to use, modify, or distribute any of the included materials for commercial purposes without express permission from the repository owner. Unauthorized use or distribution of this repository's contents may be subject to legal action. Contact the repository owner for any permissions or licensing inquiries.

## Contact

For any questions or support, please contact:
- **Mohammed AlAttar**
- Email: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- LinkedIn: [Mohammed AlAttar](https://www.linkedin.com/in/mohammed-z-alattar/)

Feel free to fork this repository, submit issues, or contribute to the script to improve its functionality.
