Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# software name
$software1 = "Steam"
$software2 = "Ubisoft"
$software3 = "EA App"
$software4 = "Battle Net"

# installation status
$software1status = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -like "*$software1*"}
$software2status = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -like "*$software2*"}
$software3status = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -like "*$software3*"}
$software4status = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object {$_.DisplayName -like "*$software4*"}

# set form size
$Form = New-Object System.Windows.Forms.Form
$Form.width = 500
$Form.height = 500
$Form.Text = 'Gamer Launcher Installer'

# set font
$Font = New-Object System.Drawing.Font("Century Gothic",10)
$Form.Font = $Font

# results textbox
$ResultsTextBox = New-Object System.Windows.Forms.TextBox
$ResultsTextBox.Location = New-Object System.Drawing.Size(200,30)
$ResultsTextBox.Size = New-Object System.Drawing.Size(250,350)
$ResultsTextBox.Multiline = $true
$ResultsTextBox.text = "make your selections on the left"
$ResultsTextBox.Enabled=$false
$Form.Controls.Add($ResultsTextBox)

# checkbox software1
$checkbox1 = new-object System.Windows.Forms.checkbox
$checkbox1.Location = new-object System.Drawing.Size(30,30)
$checkbox1.Size = new-object System.Drawing.Size(120,20)
$checkbox1.Text = "$software1"
if ($null -eq $software1status) {$checkbox1.Checked = $false} Else {$checkbox1.Checked = $true}
$Form.Controls.Add($checkbox1)

# checkbox software2
$checkbox2 = new-object System.Windows.Forms.checkbox
$checkbox2.Location = new-object System.Drawing.Size(30,50)
$checkbox2.Size = new-object System.Drawing.Size(120,20)
$checkbox2.Text = "$software2"
if ($null -eq $software2status) {$checkbox2.Checked = $false} Else {$checkbox2.Checked = $true}
$Form.Controls.Add($checkbox2)

# checkbox software3
$checkbox3 = new-object System.Windows.Forms.checkbox
$checkbox3.Location = new-object System.Drawing.Size(30,70)
$checkbox3.Size = new-object System.Drawing.Size(120,20)
$checkbox3.Text = "$software3"
if ($null -eq $software3status) {$checkbox3.Checked = $false} Else {$checkbox3.Checked = $true}
$Form.Controls.Add($checkbox3)

# checkbox software4
$checkbox4 = new-object System.Windows.Forms.checkbox
$checkbox4.Location = new-object System.Drawing.Size(30,90)
$checkbox4.Size = new-object System.Drawing.Size(120,20)
$checkbox4.Text = "$software4"
if ($null -eq $software4status) {$checkbox4.Checked = $false} Else {$checkbox4.Checked = $true}
$Form.Controls.Add($checkbox4)



# ok button
$OKButton = new-object System.Windows.Forms.Button
$OKButton.Location = new-object System.Drawing.Size(130,400)
$OKButton.Size = new-object System.Drawing.Size(100,40)
$OKButton.Text = "OK"
$Form.Controls.Add($OKButton)

# close button
$CloseButton = new-object System.Windows.Forms.Button
$CloseButton.Location = new-object System.Drawing.Size(255,400)
$CloseButton.Size = new-object System.Drawing.Size(100,40)
$CloseButton.Text = "Close"
$CloseButton.Add_Click({$Form.Close()})
$Form.Controls.Add($CloseButton)


$OKButton.Add_Click{

if($checkbox1.Checked -and $software1status -eq $null) {Start-Process -FilePath "C:\Software\SteamSetup.exe" /S ; $ResultsTextBox.AppendText("`r`nInstalling Steam")}
if($checkbox1.Checked -eq $false -and $software1status -ne $null ) {Start-Process -FilePath "C:ProgramFiles(x86)\Steam\uninstall.exe" /S ; $ResultsTextBox.AppendText("`r`nRemoving Steam")}

if($checkbox2.Checked -and $software2status -eq $null) {Start-Process -FilePath "C:\Software\UbisoftConnectInstaller.exe" /S ; $ResultsTextBox.AppendText("`r`nInstalling ubisoft")}
if($checkbox2.Checked -eq $false -and $software2status -ne $null ) {Start-Process -FilePath "C:ProgramFiles(x86)\Ubisoft\Ubisoft Game Launcher\Uninstall.exe" /S ; $ResultsTextBox.AppendText("`r`nRemoving Ubisoft")}

if($checkbox3.Checked -and $software3status -eq $null) {Start-Process -FilePath "C:\Software\EAappInstaller.exe" -Verb runAs -ArgumentList /S ; $ResultsTextBox.AppendText("`r`nInstalling EA App")}
if($checkbox3.Checked -eq $false -and $software3status -ne $null ) {Start-Process -FilePath "C:\Program Files\Electronic Arts\EA Desktop\EA Desktop\EAUninstall.exe" /S ; $ResultsTextBox.AppendText("`r`nRemoving EA App")}
    
if($checkbox4.Checked -and $software4status -eq $null) {Start-Process -FilePath "C:\Software\Battle.net-Setup.exe" -Verb runAs -ArgumentList /S ; $ResultsTextBox.AppendText("`r`nInstalling Battle Net")}
if($checkbox4.Checked -eq $false -and $software4status -ne $null ) {Start-Process -FilePath "C:ProgramFiles(x86)\Battle.net\Battle.net uninstaller.exe" /S ; $ResultsTextBox.AppendText("`r`nRemoving Battle Net")}
}

# activate form
$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog()