function d-restart-sql {
    & net stop 'MSSQL$SQLEXPRESS'
    & net start 'MSSQL$SQLEXPRESS'
}

function d-kill([Parameter(Position = 0)][string]$app) {
    & taskkill /F /IM "$app"
}