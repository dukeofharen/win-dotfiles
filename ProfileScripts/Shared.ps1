function Assert-Cmd-Ok
{
    if($LASTEXITCODE -ne 0)
    {
        Write-Error "Command not succeeded... See errors"
        Exit -1
    }
}