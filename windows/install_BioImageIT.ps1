##################################
########## Hide Console ##########
##################################
function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}


#################################
########## Making Form ##########
#################################
Add-Type -AssemblyName System.Windows.Forms
$Form                            = New-Object system.Windows.Forms.Form
$Form.Width                      = 600
$Form.Height                     = 400
$Form.text                       = "BioImageIT Installer"
$Form.AutoSize                   = $True
$OnForm                          = { Hide-Console }






############################################################
########## mkdir 'C:\Users\$USERNAME$\BioImageIT' ##########
############################################################
$name = (Get-ChildItem Env:\USERNAME).Value
Out-String -InputObject $name
mkdir C:\Users\$name\BioImageIT
Invoke-WebRequest -Uri https://github.com/bioimageit/bioimageit-install/raw/main/windows/icon.ico -OutFile C:\Users\$name\BioImageIT\ico.icon
Invoke-WebRequest -Uri https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/windows/install_main.bat -OutFile C:\Users\$name\BioImageIT\install_main.bat



##########################
########## Icon ##########
##########################
$objIcon = New-Object system.drawing.icon ("C:\Users\$name\BioImageIT\ico.icon")
$Form.Icon = $objIcon


######################################
########## Buttons & Panels ##########
######################################

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Where to install BioImageIT ?"
$Label1.AutoSize                 = $true
$Label1.location                 = New-Object System.Drawing.Point(0,10)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$path                            = New-Object system.Windows.Forms.TextBox
$path.multiline                  = $true
$path.width                      = 250
$path.height                     = 30
$path.location                   = New-Object System.Drawing.Point(300,10)
$path.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$directo                         = New-Object system.Windows.Forms.Button
$directo.text                    = " ... "
$directo.AutoSize                = $true
$directo.location                = New-Object System.Drawing.Point(550,10)
$directo.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$bioimageit                      = New-Object system.Windows.Forms.Button
$bioimageit.text                 = "Install"
$bioimageit.width                = 550
$bioimageit.height               = 40
$bioimageit.location             = New-Object System.Drawing.Point(40,200)
$bioimageit.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',14)

$fin                             = New-Object system.Windows.Forms.Button
$fin.text                        = "Close"
$fin.location                    = New-Object System.Drawing.Point(550,350)
$fin.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Form.controls.AddRange($Label1)
$Form.controls.AddRange(@($bioimageit,$directo, $fin))
$Form.controls.Add($path)




############################################
########## Launching installation ##########
############################################

$path.text = 'C:\Users\' + $name + '\BioImageIT\'

Add-Type -AssemblyName System.Windows.Forms
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
    SelectedPath = 'C:\Users\' + $name + '\BioImageIT\'
}



$directo.Add_Click({
    Write-Host "Choosing directory"
    [void]$FolderBrowser.ShowDialog()
    $FolderBrowser.SelectedPath
    $path.text = $FolderBrowser.SelectedPath
})



$bioimageit.Add_Click({
    Write-Host "Installing BioImageIT"
    cmd /c C:\Users\$name\BioImageIT\install_main.bat $FolderBrowser.SelectedPath | Tee-Object C:\Users\$name\BioImageIT\installation.log
    $path.text = "Installing BioImageIT..." 
})
 

$fin.Add_Click({
    Remove-Item C:\Users\$name\BioImageIT\install_main.bat
    $Form.Close()
})


Remove-Item C:\Users\$name\BioImageIT\ico.icon



[void]$Form.ShowDialog()
