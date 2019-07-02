# Install VSCode settings
. "$PSScriptRoot\VSCode\VSCode-Init.ps1"

# Install CreateNewTextFile
. "$PSScriptRoot\Macro\CreateNewTextFile\Install.ps1"

# Show profile installation message to user
Write-Host -ForegroundColor Green "To have access to all the PowerShell functions, add the following line to your PowerShell profile script ($profile)"
Write-Host -ForegroundColor Green ". ""$PSScriptRoot\ProfileScripts\Load-Profile.ps1"""