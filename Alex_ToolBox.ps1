#### Form settings #################################################################
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")  
 
$Form = New-Object System.Windows.Forms.Form
$Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$Form.Text = "Alex.ToolBox.com"   
$Form.Size = New-Object System.Drawing.Size(335, 600)  
$Form.StartPosition = "CenterScreen" #loads the window in the center of the screen
$Form.BackgroundImageLayout = "Zoom"
$Form.MinimizeBox = $False
$Form.MaximizeBox = $False
$Form.WindowState = "Normal"
$Form.SizeGripStyle = "Hide"
$Icon = [system.drawing.icon]::ExtractAssociatedIcon($PSHOME + "\powershell.exe")
$Form.Icon = $Icon
$Form.BackColor = [System.Drawing.Color]::LightGray
 
#### Title - Useful Tools ###################################################
$Label = New-Object System.Windows.Forms.Label
$LabelFont = New-Object System.Drawing.Font("Calibri", 16, [System.Drawing.FontStyle]::Bold)
$Label.Font = $LabelFont
$Label.Text = "Alexi_ToolBox"
$Label.AutoSize = $True
$Label.Location = New-Object System.Drawing.Size(10, 10) 
$Form.Controls.Add($Label)

#### Group boxes for buttons ########################################################
$groupBox = New-Object System.Windows.Forms.GroupBox
$groupBox.Location = New-Object System.Drawing.Size(10, 55) 
$groupBox.size = New-Object System.Drawing.Size(300, 430)
$groupBox.text = "5 Useful Tools:"
$Form.Controls.Add($groupBox) 

# Create a label for 1 button
$labelText = New-Object System.Windows.Forms.Label
$labelText.Location = New-Object System.Drawing.Size(180, 45)
$labelText.Size = New-Object System.Drawing.Size(110, 20)
$labelText.Font = $LabelFont
$labelText.Text = "Cortana"
$groupBox.Controls.Add($labelText)
 
#### 1 Button #################################################################
$Cortana = New-Object System.Windows.Forms.Button
$Cortana.Location = New-Object System.Drawing.Size(15, 30)
$Cortana.Size = New-Object System.Drawing.Size(150, 60)
$Cortana.Text = "Eemalda"
$buttonFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$Cortana.Font = $buttonFont
$Cortana.Add_Click({
     # Run the command to remove Cortana
     Get-AppxPackage -allusers | Where-Object { $_.Name -like '*Microsoft.Windows.Cortana*' } | Remove-AppxPackage -AllUsers -Confirm:$false
 })
$Cortana.Cursor = [System.Windows.Forms.Cursors]::Hand
$transparentBlueViolet = [System.Drawing.Color]::FromArgb(128, 43, 43, 226)
$Cortana.BackColor = $transparentBlueViolet
$groupBox.Controls.Add($Cortana)

# Create a label for 2 button
$labelText = New-Object System.Windows.Forms.Label
$labelText.Location = New-Object System.Drawing.Size(180, 125)
$labelText.Size = New-Object System.Drawing.Size(110, 20)
$labelText.Font = $LabelFont
$labelText.Text = "OneDrive"
$groupBox.Controls.Add($labelText)
     
#### 2 Button #################################################################
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Size(15, 110)
$button.Size = New-Object System.Drawing.Size(150, 60)
$button.Text = "Eemalda"
$buttonFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$button.Font = $buttonFont
$button.Add_Click({
     # Run the command to remove Cortana
     Get-AppxPackage -allusers | Where-Object { $_.Name -like '*Microsoft.Windows.Cortana*' } | Remove-AppxPackage -AllUsers -Confirm:$false
 })  
$button.Cursor = [System.Windows.Forms.Cursors]::Hand
$transparentBlueViolet = [System.Drawing.Color]::FromArgb(128, 43, 43, 226)
$button.BackColor = $transparentBlueViolet
$groupBox.Controls.Add($button)

# Create a label for 3 button
$labelText = New-Object System.Windows.Forms.Label
$labelText.Location = New-Object System.Drawing.Size(180, 195)
$labelText.Size = New-Object System.Drawing.Size(110, 70)
$labelText.Font = $LabelFont
$labelText.Text = "Ketta Puhastus"
$groupBox.Controls.Add($labelText)
     
#### 3 Button #################################################################
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Size(15, 190)
$button.Size = New-Object System.Drawing.Size(150, 60)
$button.Text = "Kaivita"
$buttonFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$button.Font = $buttonFont
function DiskCleanUp { cleanmgr.exe /d C: /VERYLOWDISKDism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase }
$button.Add_Click({ 
     DiskCleanUp 
})
$button.Cursor = [System.Windows.Forms.Cursors]::Hand
$transparentBlueViolet = [System.Drawing.Color]::FromArgb(128, 43, 43, 226)
$button.BackColor = $transparentBlueViolet
$groupBox.Controls.Add($button)

# Create a label for 4 button
$labelText = New-Object System.Windows.Forms.Label
$labelText.Location = New-Object System.Drawing.Size(180, 275)
$labelText.Size = New-Object System.Drawing.Size(110, 60)
$labelText.Font = $LabelFont
$labelText.Text = "Windows Update"
$groupBox.Controls.Add($labelText)
             
#### 4 Button #################################################################
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Size(15, 270)
$button.Size = New-Object System.Drawing.Size(150, 60)
$button.Text = "Uuenda"
$buttonFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$button.Font = $buttonFont
function InstallPSWindowsUpdateModule {
     if (-not (Get-Module -Name PSWindowsUpdate -ListAvailable)) {
          Install-Module -Name PSWindowsUpdate -Force
          Write-Host "PSWindowsUpdate module installed successfully"
     }
     else {
          Write-Host "PSWindowsUpdate module is already installed"
     }
}
 
$button.Add_Click({
     # Ensure the PSWindowsUpdate module is installed
     InstallPSWindowsUpdateModule
 
     # If the module is installed, perform a Windows Update search
     if (Get-Module -Name PSWindowsUpdate -ListAvailable) {
         # Import the module if it wasn't already imported
         if (-not (Get-Module -Name PSWindowsUpdate)) {
             Import-Module -Name PSWindowsUpdate
         }
 
         # Execute Windows Update search using the PSWindowsUpdate module
         Get-WindowsUpdate -MicrosoftUpdate
     } else {
         Write-Host "PSWindowsUpdate module is not installed. Please check for installation errors."
     }
 })    
$button.Cursor = [System.Windows.Forms.Cursors]::Hand
$transparentBlueViolet = [System.Drawing.Color]::FromArgb(128, 43, 43, 226)
$button.BackColor = $transparentBlueViolet
$groupBox.Controls.Add($button)

# Create a label for 5 Button
$labelText = New-Object System.Windows.Forms.Label
$labelText.Location = New-Object System.Drawing.Size(180, 355)
$labelText.Size = New-Object System.Drawing.Size(100, 60)
$labelText.Font = $LabelFont
$labelText.Text = "Systeemi-parandus"
$groupBox.Controls.Add($labelText)
     
#### 5 Button #################################################################
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Size(15, 350)
$button.Size = New-Object System.Drawing.Size(150, 60)
$button.Text = "Kaivita"
$buttonFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$button.Font = $buttonFont
$button.Add_Click({
     # Run SFC /scannow
     Start-Process "sfc" -ArgumentList "/scannow" -NoNewWindow -Wait
 })
$button.Cursor = [System.Windows.Forms.Cursors]::Hand
$transparentBlueViolet = [System.Drawing.Color]::FromArgb(128, 43, 43, 226)
$button.BackColor = $transparentBlueViolet
$groupBox.Controls.Add($button)

$Form.Add_Shown({ $Form.Activate() })
[void] $Form.ShowDialog()