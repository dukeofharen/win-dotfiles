$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Shared.ps1"

function d-del-obj-bin(
    [Parameter(Position = 0)][string]$path,
    [Parameter(Position = 1)][bool]$completeClean = $false) {
    if (!$path) {
        $path = (Get-Location).Path
    }

    if (!$completeClean) {
        $include = @("bin", "obj")
    }
    else {
        $include = @("bin", "obj", "packages", ".vs")
    }

    Write-Host "Deleting all Visual Studio in $path with inclusion pattern $include"
    Get-ChildItem $path -include $include -Recurse -Force | foreach ($_) { remove-item $_.fullname -Force -Recurse }
}

function d-transform-xml(
    [Parameter(Position = 0)][string]$xmlPath,
    [Parameter(Position = 1)][string]$xdtPath,
    [Parameter(Position = 2)][string]$outputPath) {
    if (!$xmlPath -or !(Test-Path -path $xmlPath -PathType Leaf)) {
        throw "File not found. $xmlPath";
    }
        
    if (!$xdtPath -or !(Test-Path -path $xdtPath -PathType Leaf)) {
        throw "File not found. $xdtPath";
    }

    $transformDll = "$PSScriptRoot\Microsoft.Web.XmlTransform.dll"
    Add-Type -Path $transformDll

    $xmldoc = New-Object Microsoft.Web.XmlTransform.XmlTransformableDocument;
    $xmldoc.PreserveWhitespace = $true
    $xmldoc.Load($xmlPath);

    $transf = New-Object Microsoft.Web.XmlTransform.XmlTransformation($xdtPath);
    if ($transf.Apply($xmldoc) -eq $false) {
        throw "Transformation failed."
    }

    $xmlContents = $xmldoc.InnerXml
    if (!$outputPath) {
        Write-Host $xmlContents
    }
    else {
        $xmlContents | Out-File $outputPath
    }
}

# Updates .NET Core NuGet packages recursively
function d-net-core-nuget-update($rootFolder = $null) {
    if ($null -eq $rootFolder) {
        $rootFolder = Get-Location
    }

    Write-Host "Updating .NET Core NuGet packages in $rootFolder"

    # Fetch all .csproj files
    $csprojs = Get-ChildItem -Path $rootFolder -Filter *.csproj -Recurse
    foreach ($csproj in $csprojs) {
        Write-Host "Reading file $($csproj.FullName)"
        [xml]$csprojXml = Get-Content -Path $csproj.FullName
        $packageRefNodes = Select-Xml -Xml $csprojXml -XPath ".//PackageReference"
        foreach ($node in $packageRefNodes) {
            $packageName = $node.node.Include
            Write-Host "dotnet add $($csproj.FullName) package $packageName"
            & dotnet add $($csproj.FullName) package $packageName
            Assert-Cmd-Ok
        }
    }
}