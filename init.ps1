# Install VSCode settings
$vscodeSettingsFolder = "$($env:USERPROFILE)\AppData\Roaming\Code\User"
$vscodeFolder = "$PSScriptRoot\VSCode"
Write-Host "Moving files from $vscodeFolder to $vscodeSettingsFolder"
Copy-Item -Path "$vscodeFolder\*" -Destination $vscodeSettingsFolder -Force

# Show profile installation message to user
Write-Host -ForegroundColor Green "To have access to all the PowerShell functions, add the following line to your PowerShell profile script ($profile)"
Write-Host -ForegroundColor Green ". ""$PSScriptRoot\ProfileScripts\Load-Profile.ps1"""