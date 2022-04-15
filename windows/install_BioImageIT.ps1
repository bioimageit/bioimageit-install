Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$ErrorActionPreference = 'SilentlyContinue'
$wshell = New-Object -ComObject Wscript.Shell
$Button = [System.Windows.MessageBoxButton]::YesNoCancel
$ErrorIco = [System.Windows.MessageBoxImage]::Error



$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(500,500)
$Form.text                       = "BioImageIT Installer"
$Form.StartPosition              = "CenterScreen"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#e9e9e9")
$Form.AutoScaleDimensions     = '192, 192'
$Form.AutoScaleMode           = "Dpi"
$Form.AutoSize                = $True
$Form.AutoScroll              = $True
$Form.ClientSize              = '500, 500'
$Form.FormBorderStyle         = 'FixedSingle'


############################################################
########## mkdir 'C:\Users\$USERNAME$\BioImageIT' ##########
############################################################
$name = (Get-ChildItem Env:\USERNAME).Value
Out-String -InputObject $name
mkdir C:\Users\$name\BioImageIT

######################################
########## Buttons & Panels ##########
######################################
$iconBytes                       = [Convert]::FromBase64String($iconBase64)
$stream                          = New-Object IO.MemoryStream($iconBytes, 0, $iconBytes.Length)
$stream.Write($iconBytes, 0, $iconBytes.Length)
$Form.Icon                    = [System.Drawing.Icon]::FromHandle((New-Object System.Drawing.Bitmap -Argument $stream).GetHIcon())

$Form.Width                   = $objImage.Width
$Form.Height                  = $objImage.Height

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 400
$Panel1.width                    = 300
$Panel1.location                 = New-Object System.Drawing.Point(1,1)

$directo                         = New-Object system.Windows.Forms.Button
$directo.text                    = "Installation directory"
$directo.width                   = 260
$directo.height                  = 30
$directo.location                = New-Object System.Drawing.Point(40,50)
$directo.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$bioimageit                      = New-Object system.Windows.Forms.Button
$bioimageit.text                 = "Install"
$bioimageit.width                = 260
$bioimageit.height               = 30
$bioimageit.location             = New-Object System.Drawing.Point(40,200)
$bioimageit.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Install BioImageIT ?"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(40,100)
$Label9.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ResultText                      = New-Object system.Windows.Forms.TextBox
$ResultText.multiline            = $true
$ResultText.width                = 500
$ResultText.height               = 50
$ResultText.location             = New-Object System.Drawing.Point(450,100)
$ResultText.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)





$Form.controls.AddRange(@($Panel1,$Panel2,$Label3,$Label15,$Panel4,$PictureBox1,$Label1,$Panel3,$ResultText,$Label10,$Label11,$urlfixwinstartup,$urlremovevirus,$urlcreateiso))
$Panel1.controls.AddRange(@($bioimageit,$directo))
$Panel2.controls.AddRange(@($essentialtweaks,$backgroundapps,$cortana,$actioncenter,$darkmode,$performancefx,$onedrive,$lightmode,$essentialundo,$EActionCenter,$ECortana,$RBackgroundApps,$HTrayIcons,$EClipboardHistory,$ELocation,$InstallOneDrive,$removebloat,$reinstallbloat,$WarningLabel,$Label5,$appearancefx,$STrayIcons,$EHibernation,$dualboottime))
$Panel4.controls.AddRange(@($defaultwindowsupdate,$securitywindowsupdate,$Label16,$Label17,$Label18,$Label19,$windowsupdatefix,$disableupdates,$enableupdates,$Label12))
$Panel3.controls.AddRange(@($yourphonefix,$ncpa,$oldcontrolpanel,$oldsoundpanel,$oldsystempanel,$NFS,$laptopnumlock,$Virtualization,$oldpower,$restorepower))




############################################
########## Launching installation ##########
############################################

Add-Type -AssemblyName System.Windows.Forms
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
    SelectedPath = 'C:\Users\' + $name + '\BioImageIT\'
}



$directo.Add_Click({
    Write-Host "Choosing directory"
    [void]$FolderBrowser.ShowDialog()
    $FolderBrowser.SelectedPath
    $ResultText.text = $FolderBrowser.SelectedPath
})



$bioimageit.Add_Click({
    Write-Host "Installing BioImageIT"
    Invoke-WebRequest -Uri https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/windows/install_main.bat -OutFile install_main.bat
    $ResultText.text = "Installing BioImageIT..." 
    Start-Process install_main.bat $FolderBrowser.SelectedPath
    $ResultText.text = 'Start-Process install_main.bat ' + $FolderBrowser.SelectedPath
})

# Remove-Item install_main.bat





[void]$Form.ShowDialog()
