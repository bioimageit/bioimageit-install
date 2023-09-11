#################################
######## Hiding Console #########
#################################


Add-Type -Name Window -Namespace Console -MemberDefinition '

[DllImport("Kernel32.dll")]

public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]

public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);

'


function Hide-Console {

   $consolePtr = [Console.Window]::GetConsoleWindow()

 #0 hide

[Console.Window]::ShowWindow($consolePtr, 0)

}

Hide-Console





#################################
########## Making Form ##########
#################################
Add-Type -AssemblyName System.Windows.Forms

$Form                            = New-Object system.Windows.Forms.Form
$Form.Width                      = 600
$Form.Height                     = 400
$Form.text                       = "BioImageIT Installer"
$Form.AutoSize                   = $True
$Form.BackColor                  = "white"
$Form.FormBorderStyle            = "FixedDialog"
$Form.MaximizeBox                = $false
$Form.Opacity                    = .96


############################################################
########## mkdir 'C:\Users\$USERNAME$\BioImageIT' ##########
############################################################
$name = (Get-ChildItem Env:\USERNAME).Value
Out-String -InputObject $name
mkdir C:\Users\$name\BioImageIT





##########################
########## Icon ##########
##########################
Invoke-WebRequest -Uri https://github.com/bioimageit/bioimageit-install/raw/main/windows/icon.ico -OutFile C:\Users\$name\BioImageIT\ico.icon
$objIcon = New-Object system.drawing.icon ("C:\Users\$name\BioImageIT\ico.icon")
$Form.Icon = $objIcon


######################################
########## Buttons & Panels ##########
######################################

$where                           = New-Object system.Windows.Forms.Label
$where.text                      = "Where to install BioImageIT ?"
$where.AutoSize                  = $true
$where.location                  = New-Object System.Drawing.Point(40,65)
$where.Font                      = New-Object System.Drawing.Font('Segoe UI',10)

$path                            = New-Object system.Windows.Forms.TextBox
$path.multiline                  = $true
$path.width                      = 230
$path.height                     = 35
$path.location                   = New-Object System.Drawing.Point(280,60)
$path.Font                       = New-Object System.Drawing.Font('Segoe UI',12)

$directo                         = New-Object system.Windows.Forms.Button
$directo.text                    = " ... "
$directo.AutoSize                = $true
$directo.location                = New-Object System.Drawing.Point(510,60)
$directo.Font                    = New-Object System.Drawing.Font('Segoe UI',10)
$directo.BackColor               = "LightGray"

$bioimageit                      = New-Object system.Windows.Forms.Button
$bioimageit.text                 = "Install"
$bioimageit.width                = 545
$bioimageit.height               = 40
$bioimageit.location             = New-Object System.Drawing.Point(40,150)
$bioimageit.Font                 = New-Object System.Drawing.Font('Segoe UI',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$bioimageit.BackColor            = "LightGray"

$ProgressBar                     = New-Object System.Windows.Forms.ProgressBar
$ProgressBar.Location            = New-Object System.Drawing.Point(40,200)
$ProgressBar.Size                = New-Object System.Drawing.Size(545,40)
$ProgressBar.Style               = "Continuous"
$ProgressBar.MarqueeAnimationSpeed = 20
$ProgressBar.Value               = 0

$fin                             = New-Object system.Windows.Forms.Button
$fin.text                        = "Close"
$fin.location                    = New-Object System.Drawing.Point(550,350)
$fin.Font                        = New-Object System.Drawing.Font('Segoe UI',10)
$fin.BackColor                   = "LightGray"

$licence                         = New-Object system.Windows.Forms.Label
$licence.text                    = "By downloading, installing, or otherwise using BioImageIT, you accept and agree to be bound by all of the terms and conditions of the following licenses:`r`n- BioImageIT: BSD 4-Clause 'Original' or 'Old' License.`r`n- BioImageIT_Omero: GNU General Public License v2.0."
$licence.width                   = 545
$licence.height                  = 100
$licence.location                = New-Object System.Drawing.Point(40,250)
$licence.Font                    = New-Object System.Drawing.Font('Segoe UI',8)

$Form.controls.AddRange(@($where, $licence))
$Form.controls.AddRange(@($bioimageit,$directo, $fin, $ProgressBar))
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
    $bitt_install_version = "fixing-v0.1.3"
    Write-Host "Installing BioImageIT $bitt_install_version..."
    
    $config_bat = "$($path.text)config.bat"
    $conda_bat ="$($path.text)install_conda.bat"
    $git_bat = "$($path.text)install_git.bat"
    $fiji_bat = "$($path.text)install_fiji.bat"

    Invoke-WebRequest -Uri https://raw.githubusercontent.com/bioimageit/bioimageit-install/$bitt_install_version/windows/config.bat -OutFile $config_bat
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/bioimageit/bioimageit-install/$bitt_install_version/windows/install_conda.bat -OutFile $conda_bat
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/bioimageit/bioimageit-install/$bitt_install_version/windows/install_git.bat -OutFile $git_bat
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/bioimageit/bioimageit-install/$bitt_install_version/windows/install_fiji.bat -OutFile $fiji_bat
    $ProgressBar.Value = 10

    cmd /c $conda_bat $path.text
    $ProgressBar.Value = 40

    cmd /c $git_bat $path.text
    $ProgressBar.Value = 70
    
    cmd /c $fiji_bat $path.text
    $path.text = "Installing BioImageIT..." 
    $ProgressBar.Value = 100
})
 

$fin.Add_Click({
    Remove-Item "$($path.text)config.bat"
    Remove-Item "$($path.text)install_conda.bat"
    Remove-Item "$($path.text)install_git.bat"
    Remove-Item "$($path.text)install_fiji.bat"
    $Form.Close()
})


Remove-Item "$($path.text)ico.icon"



[void]$Form.ShowDialog()
