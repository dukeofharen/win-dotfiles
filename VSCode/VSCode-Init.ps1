$vscodeSettingsFolder = "$($env:USERPROFILE)\AppData\Roaming\Code\User"
$vscodeFolder = "$PSScriptRoot"
Write-Host "Moving files from $vscodeFolder to $vscodeSettingsFolder"
Copy-Item -Path "$vscodeFolder\*" -Destination $vscodeSettingsFolder -Force