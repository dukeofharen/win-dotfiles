$vscodeSettingsFolder = "$($env:USERPROFILE)\AppData\Roaming\Code\User"
$vscodeFolder = "$PSScriptRoot"
Write-Host "Moving files from $vscodeSettingsFolder to $vscodeFolder"
Copy-Item -Path "$vscodeSettingsFolder\*.json" -Destination $vscodeFolder -Force