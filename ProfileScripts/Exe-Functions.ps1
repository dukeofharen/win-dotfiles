function d-restart-sql {
    & net stop 'MSSQLSERVER'
    & net start 'MSSQLSERVER'
}

function d-stop-sql {
    & net stop 'MSSQLSERVER'
}

function d-start-sql {
    & net start 'MSSQLSERVER'
}

function d-restart-mysql {
    & net stop 'MySQL80'
    & net start 'MySQL80'
}

function d-stop-mysql {
    & net stop 'MySQL80'
}

function d-start-mysql {
    & net start 'MySQL80'
}

function d-kill([Parameter(Position = 0)][string]$app) {
    & taskkill /F /IM "$app"
}