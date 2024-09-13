
Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "IntuneWinAppUtil GUI"
$form.Size = New-Object System.Drawing.Size(500,250)
$form.StartPosition = "CenterScreen"

# Source Folder Label and TextBox
$sourceLabel = New-Object System.Windows.Forms.Label
$sourceLabel.Text = "Source Folder:"
$sourceLabel.Location = New-Object System.Drawing.Point(10,20)
$sourceLabel.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($sourceLabel)

$sourceTextBox = New-Object System.Windows.Forms.TextBox
$sourceTextBox.Location = New-Object System.Drawing.Point(120,20)
$sourceTextBox.Size = New-Object System.Drawing.Size(250,20)
$form.Controls.Add($sourceTextBox)

$sourceButton = New-Object System.Windows.Forms.Button
$sourceButton.Text = "Browse..."
$sourceButton.Location = New-Object System.Drawing.Point(380,18)
$sourceButton.Size = New-Object System.Drawing.Size(75,23)
$form.Controls.Add($sourceButton)

$sourceButton.Add_Click({
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    if ($folderBrowser.ShowDialog() -eq "OK") {
        $sourceTextBox.Text = $folderBrowser.SelectedPath
    }
})

# Setup File Label and TextBox
$setupLabel = New-Object System.Windows.Forms.Label
$setupLabel.Text = "Setup File:"
$setupLabel.Location = New-Object System.Drawing.Point(10,60)
$setupLabel.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($setupLabel)

$setupTextBox = New-Object System.Windows.Forms.TextBox
$setupTextBox.Location = New-Object System.Drawing.Point(120,60)
$setupTextBox.Size = New-Object System.Drawing.Size(250,20)
$form.Controls.Add($setupTextBox)

$setupButton = New-Object System.Windows.Forms.Button
$setupButton.Text = "Browse..."
$setupButton.Location = New-Object System.Drawing.Point(380,58)
$setupButton.Size = New-Object System.Drawing.Size(75,23)
$form.Controls.Add($setupButton)

$setupButton.Add_Click({
    $fileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $fileBrowser.Filter = "Executable Files (*.exe)|*.exe|All Files (*.*)|*.*"
    if ($fileBrowser.ShowDialog() -eq "OK") {
        $setupTextBox.Text = $fileBrowser.FileName
    }
})

# Output Folder Label and TextBox
$outputLabel = New-Object System.Windows.Forms.Label
$outputLabel.Text = "Output Folder:"
$outputLabel.Location = New-Object System.Drawing.Point(10,100)
$outputLabel.Size = New-Object System.Drawing.Size(100,20)
$form.Controls.Add($outputLabel)

$outputTextBox = New-Object System.Windows.Forms.TextBox
$outputTextBox.Location = New-Object System.Drawing.Point(120,100)
$outputTextBox.Size = New-Object System.Drawing.Size(250,20)
$form.Controls.Add($outputTextBox)

$outputButton = New-Object System.Windows.Forms.Button
$outputButton.Text = "Browse..."
$outputButton.Location = New-Object System.Drawing.Point(380,98)
$outputButton.Size = New-Object System.Drawing.Size(75,23)
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
$convertButton.Location = New-Object System.Drawing.Point(200,150)
$convertButton.Size = New-Object System.Drawing.Size(100,30)
$form.Controls.Add($convertButton)

# Drag and Drop functionality
$sourceTextBox.AllowDrop = $true
$setupTextBox.AllowDrop = $true
$outputTextBox.AllowDrop = $true

$sourceTextBox.Add_DragEnter({
    $sourceTextBox.DragDrop += {
        $sourceTextBox.Text = $_.Data.GetData("Text")
    }
    $_.Effect = "Copy"
})

$setupTextBox.Add_DragEnter({
    $setupTextBox.DragDrop += {
        $setupTextBox.Text = $_.Data.GetData("Text")
    }
    $_.Effect = "Copy"
})

$outputTextBox.Add_DragEnter({
    $outputTextBox.DragDrop += {
        $outputTextBox.Text = $_.Data.GetData("Text")
    }
    $_.Effect = "Copy"
})

# Button Click Event
$convertButton.Add_Click({
    $sourceFolder = $sourceTextBox.Text
    $setupFile = $setupTextBox.Text
    $outputFolder = $outputTextBox.Text

    $command = "IntuneWinAppUtil.exe -c `"$sourceFolder`" -s `"$setupFile`" -o `"$outputFolder`""
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c $command" -NoNewWindow -Wait

    [System.Windows.Forms.MessageBox]::Show("Conversion Completed")
})

# Show Form
$form.ShowDialog()
