# IntuneWinAppUtil GUI (fixed)

# --- Force Windows PowerShell 5.1 + STA for WinForms reliability ---
if ($PSVersionTable.PSVersion.Major -ge 6) {
    Start-Process -FilePath "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe" `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -STA -File `"$PSCommandPath`"" `
        -Verb RunAs
    exit
}

if ([System.Threading.Thread]::CurrentThread.ApartmentState -ne 'STA') {
    Start-Process -FilePath "powershell.exe" `
        -ArgumentList "-NoProfile -ExecutionPolicy Bypass -STA -File `"$PSCommandPath`"" `
        -Verb RunAs
    exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Locate IntuneWinAppUtil.exe in the same folder as the script ---
$ScriptDir = Split-Path -Parent $PSCommandPath
$IntuneUtil = Join-Path $ScriptDir "IntuneWinAppUtil.exe"

if (!(Test-Path $IntuneUtil)) {
    [System.Windows.Forms.MessageBox]::Show(
        "IntuneWinAppUtil.exe not found in:`n$ScriptDir`n`nPut IntuneWinAppUtil.exe next to this GUI script.",
        "Missing IntuneWinAppUtil.exe",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    ) | Out-Null
    exit
}

# --- Form ---
$form = New-Object System.Windows.Forms.Form
$form.Text = "IntuneWinAppUtil GUI"
$form.Size = New-Object System.Drawing.Size(560,260)
$form.StartPosition = "CenterScreen"

# Source Folder
$sourceLabel = New-Object System.Windows.Forms.Label
$sourceLabel.Text = "Source Folder:"
$sourceLabel.Location = New-Object System.Drawing.Point(10,20)
$sourceLabel.Size = New-Object System.Drawing.Size(110,20)
$form.Controls.Add($sourceLabel)

$sourceTextBox = New-Object System.Windows.Forms.TextBox
$sourceTextBox.Location = New-Object System.Drawing.Point(130,20)
$sourceTextBox.Size = New-Object System.Drawing.Size(310,20)
$form.Controls.Add($sourceTextBox)

$sourceButton = New-Object System.Windows.Forms.Button
$sourceButton.Text = "Browse..."
$sourceButton.Location = New-Object System.Drawing.Point(450,18)
$sourceButton.Size = New-Object System.Drawing.Size(85,23)
$form.Controls.Add($sourceButton)

$sourceButton.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderBrowser.ShowDialog() -eq "OK") {
        $sourceTextBox.Text = $folderBrowser.SelectedPath
    }
})

# Setup File
$setupLabel = New-Object System.Windows.Forms.Label
$setupLabel.Text = "Setup File:"
$setupLabel.Location = New-Object System.Drawing.Point(10,60)
$setupLabel.Size = New-Object System.Drawing.Size(110,20)
$form.Controls.Add($setupLabel)

$setupTextBox = New-Object System.Windows.Forms.TextBox
$setupTextBox.Location = New-Object System.Drawing.Point(130,60)
$setupTextBox.Size = New-Object System.Drawing.Size(310,20)
$form.Controls.Add($setupTextBox)

$setupButton = New-Object System.Windows.Forms.Button
$setupButton.Text = "Browse..."
$setupButton.Location = New-Object System.Drawing.Point(450,58)
$setupButton.Size = New-Object System.Drawing.Size(85,23)
$form.Controls.Add($setupButton)

$setupButton.Add_Click({
    $fileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $fileBrowser.Filter = "Installer/Executable (*.exe;*.msi;*.bat;*.cmd;*.ps1)|*.exe;*.msi;*.bat;*.cmd;*.ps1|All Files (*.*)|*.*"
    if (Test-Path $sourceTextBox.Text) { $fileBrowser.InitialDirectory = $sourceTextBox.Text }
    if ($fileBrowser.ShowDialog() -eq "OK") {
        $setupTextBox.Text = $fileBrowser.FileName
    }
})

# Output Folder
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Text = "Output Folder:"
$outputLabel.Location = New-Object System.Drawing.Point(10,100)
$outputLabel.Size = New-Object System.Drawing.Size(110,20)
$form.Controls.Add($outputLabel)

$outputTextBox = New-Object System.Windows.Forms.TextBox
$outputTextBox.Location = New-Object System.Drawing.Point(130,100)
$outputTextBox.Size = New-Object System.Drawing.Size(310,20)
$form.Controls.Add($outputTextBox)

$outputButton = New-Object System.Windows.Forms.Button
$outputButton.Text = "Browse..."
$outputButton.Location = New-Object System.Drawing.Point(450,98)
$outputButton.Size = New-Object System.Drawing.Size(85,23)
$form.Controls.Add($outputButton)

$outputButton.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderBrowser.ShowDialog() -eq "OK") {
        $outputTextBox.Text = $folderBrowser.SelectedPath
    }
})

# Convert Button
$convertButton = New-Object System.Windows.Forms.Button
$convertButton.Text = "Convert"
$convertButton.Location = New-Object System.Drawing.Point(220,150)
$convertButton.Size = New-Object System.Drawing.Size(120,34)
$form.Controls.Add($convertButton)

# Status label
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = ""
$statusLabel.Location = New-Object System.Drawing.Point(10,195)
$statusLabel.Size = New-Object System.Drawing.Size(525,20)
$form.Controls.Add($statusLabel)

# --- Drag & Drop (correct) ---
foreach ($tb in @($sourceTextBox,$setupTextBox,$outputTextBox)) {
    $tb.AllowDrop = $true
    $tb.Add_DragEnter({
        if ($_.Data.GetDataPresent([Windows.Forms.DataFormats]::FileDrop)) { $_.Effect = 'Copy' }
        else { $_.Effect = 'None' }
    })
}

$sourceTextBox.Add_DragDrop({
    $items = $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($items -and (Test-Path $items[0]) -and (Get-Item $items[0]).PSIsContainer) {
        $sourceTextBox.Text = $items[0]
    }
})

$setupTextBox.Add_DragDrop({
    $items = $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($items -and (Test-Path $items[0]) -and -not (Get-Item $items[0]).PSIsContainer) {
        $setupTextBox.Text = $items[0]
    }
})

$outputTextBox.Add_DragDrop({
    $items = $_.Data.GetData([Windows.Forms.DataFormats]::FileDrop)
    if ($items -and (Test-Path $items[0]) -and (Get-Item $items[0]).PSIsContainer) {
        $outputTextBox.Text = $items[0]
    }
})

# --- Convert ---
$convertButton.Add_Click({
    $sourceFolder = $sourceTextBox.Text.Trim()
    $setupPath    = $setupTextBox.Text.Trim()
    $outputFolder = $outputTextBox.Text.Trim()

    if (!(Test-Path $sourceFolder)) {
        [System.Windows.Forms.MessageBox]::Show("Source folder not found.","Error") | Out-Null
        return
    }
    if (!(Test-Path $setupPath)) {
        [System.Windows.Forms.MessageBox]::Show("Setup file not found.","Error") | Out-Null
        return
    }
    if (!(Test-Path $outputFolder)) {
        [System.Windows.Forms.MessageBox]::Show("Output folder not found.","Error") | Out-Null
        return
    }

    # IntuneWinAppUtil requires the setup file to be inside the source folder (pass leaf name to -s)
    $setupLeaf = Split-Path -Leaf $setupPath
    $setupInsideSource = Join-Path $sourceFolder $setupLeaf

    if (!(Test-Path $setupInsideSource)) {
        [System.Windows.Forms.MessageBox]::Show(
            "The setup file must be inside the Source Folder for IntuneWinAppUtil.`n`nMove/copy:`n$setupPath`ninto:`n$sourceFolder`n`nThen select it again.",
            "Invalid setup location",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        ) | Out-Null
        return
    }

    $args = @("-c", $sourceFolder, "-s", $setupLeaf, "-o", $outputFolder)

    $statusLabel.Text = "Running: IntuneWinAppUtil.exe $($args -join ' ')"
    $form.Refresh()

    $p = Start-Process -FilePath $IntuneUtil -ArgumentList $args -NoNewWindow -Wait -PassThru

    if ($p.ExitCode -eq 0) {
        $statusLabel.Text = "Completed successfully."
        [System.Windows.Forms.MessageBox]::Show("Conversion Completed","Done") | Out-Null
    } else {
        $statusLabel.Text = "Failed. ExitCode: $($p.ExitCode)"
        [System.Windows.Forms.MessageBox]::Show("Conversion failed. ExitCode: $($p.ExitCode)","Failed") | Out-Null
    }
})

# Show
[void]$form.ShowDialog()