. "$PSScriptRoot\..\..\ProfileScripts\Shortcut-Functions.ps1"

$mainDrive = (Get-Item $env:windir).PSDrive.Name
$installPath = "$($mainDrive):\bin\CreateNewTextFile"
Write-Host "Installing CreateNewTextFile.exe to $installPath"
Stop-Process -Name "CreateNewTextFile" -ErrorAction SilentlyContinue

if(!(Test-Path $installPath)) {
    Write-Host "Creating directory $installPath"
    New-Item -ItemType Directory $installPath
}

$exePath = "$PSScriptRoot\CreateNewTextFile.exe"
Copy-Item $exePath $installPath -Force

d-create-startup-shortcut -source $exePath -linkName "CreateNewTextFile"