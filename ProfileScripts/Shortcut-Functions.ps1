# Create a shortcut from a given source to the startmenu.
function d-create-shortcut($source, $linkName, $folderName = $null) {
    if($null -eq $folderName) {
        $folderName = "$($env:APPDATA)\Microsoft\Windows\Start Menu\Programs"
    }

    $linkPath = "$folderName\$linkName.lnk"
    $fullSourcePath = Resolve-Path $source

    Write-Host "Creating shortcut of '$fullSourcePath' to '$linkPath'"
    $objShell = New-Object -ComObject ("WScript.Shell")
    $shortcut = $objShell.CreateShortcut($linkPath) 
    $shortcut.TargetPath = $fullSourcePath
    $shortcut.Save()
}

function d-create-startup-shortcut($source, $linkName) {
    d-create-shortcut -source $source -linkName $linkName -folderName "$($env:APPDATA)\Microsoft\Windows\Start Menu\Programs\Startup"
}