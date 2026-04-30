# Script de Monitoreo para Windows PowerShell
# Uso: .\monitor.ps1

param(
    [int]$refresh = 5,
    [string]$mode = "dashboard"
)

function Show-Dashboard {
    $logins = @(Select-String "LOGIN_SUCCESS" logs/activity.log -ErrorAction SilentlyContinue).Count
    $dataExposure = @(Select-String "GET_ALL_USERS" logs/activity.log -ErrorAction SilentlyContinue).Count
    $adminAccess = @(Select-String "ADMIN_STATS" logs/activity.log -ErrorAction SilentlyContinue).Count
    $totalRequests = @(Select-String "GET|POST" logs/connections.log -ErrorAction SilentlyContinue).Count
    $uniqueIPs = @(
        (Get-Content logs/connections.log -ErrorAction SilentlyContinue) | 
        Select-String "IP:" | 
        ForEach-Object { $_ -replace '.*IP: ([\d.]+).*', '$1' } | 
        Sort-Object -Unique
    ).Count

    Clear-Host
    
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║    SECURE AUDIT LAB - DASHBOARD DE MONITOREO          ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    Write-Host "`n📊 ESTADÍSTICAS GENERALES"
    Write-Host "  ├─ Total de Requests: " -NoNewline; Write-Host "$totalRequests" -ForegroundColor Yellow
    Write-Host "  ├─ IPs Únicas: " -NoNewline; Write-Host "$uniqueIPs" -ForegroundColor Yellow
    Write-Host "  ├─ Logins Exitosos: " -NoNewline; Write-Host "$logins" -ForegroundColor Green
    Write-Host "  ├─ Acceso a Datos Sensibles: " -NoNewline; Write-Host "$dataExposure" -ForegroundColor Red
    Write-Host "  └─ Acceso Admin (sin auth): " -NoNewline; Write-Host "$adminAccess" -ForegroundColor Red
    
    Write-Host "`n🖥️  ÚLTIMAS 5 CONEXIONES:"
    Write-Host "─" * 56
    Get-Content logs/connections.log -ErrorAction SilentlyContinue -Tail 5 | ForEach-Object {
        $_ -replace '^\[([^\]]+)\]', "[$(([datetime]::Parse([datetime]::Parse($1).ToString())).ToString('HH:mm:ss'))]"
    }
    
    Write-Host "`n📋 ÚLTIMAS 5 ACTIVIDADES:"
    Write-Host "─" * 56
    Get-Content logs/activity.log -ErrorAction SilentlyContinue -Tail 5 | ForEach-Object {
        $_ -replace '^\[([^\]]+)\]', "[$(([datetime]::Parse([datetime]::Parse($1).ToString())).ToString('HH:mm:ss'))]"
    }
    
    Write-Host "`n⏰ Próxima actualización en $refresh segundos... (Ctrl+C para salir)`n" -ForegroundColor Gray
}

function Show-Connections {
    Clear-Host
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║    REGISTROS DE CONEXIÓN (Tiempo Real)                ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    Get-Content logs/connections.log -Wait -ErrorAction SilentlyContinue
}

function Show-Activity {
    Clear-Host
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║    REGISTROS DE ACTIVIDAD (Tiempo Real)               ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    Get-Content logs/activity.log -Wait -ErrorAction SilentlyContinue
}

function Show-TopStudents {
    Clear-Host
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║    ESTUDIANTES MÁS ACTIVOS                            ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    Write-Host "`n🔝 Por número de conexiones:`n"
    
    (Get-Content logs/connections.log -ErrorAction SilentlyContinue) | 
        Select-String "IP:" | 
        ForEach-Object { $_ -replace '.*IP: ([\d.]+).*', '$1' } | 
        Group-Object | 
        Sort-Object Count -Descending | 
        Select-Object -First 10 | 
        ForEach-Object { Write-Host ("  {0:2}. IP: {1,-15} Conexiones: {2}" -f ++$i, $_.Name, $_.Count) }
}

function Show-Help {
    Clear-Host
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║    SECURE AUDIT LAB - MONITOR DE SEGURIDAD            ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    
    Write-Host "`n📖 USO:"
    Write-Host "  .\monitor.ps1 -mode dashboard    # Dashboard interactivo (default)"
    Write-Host "  .\monitor.ps1 -mode connections  # Conexiones en tiempo real"
    Write-Host "  .\monitor.ps1 -mode activity     # Actividades en tiempo real"
    Write-Host "  .\monitor.ps1 -mode students     # Estudiantes más activos"
    Write-Host "  .\monitor.ps1 -mode help         # Esta ayuda"
    
    Write-Host "`n⚙️  PARÁMETROS:"
    Write-Host "  -refresh <segundos>  # Intervalo de actualización (default: 5)"
    Write-Host "  -mode <tipo>         # Tipo de vista"
    
    Write-Host "`n💡 EJEMPLOS:"
    Write-Host "  .\monitor.ps1                         # Dashboard cada 5 seg"
    Write-Host "  .\monitor.ps1 -refresh 2              # Dashboard cada 2 seg"
    Write-Host "  .\monitor.ps1 -mode connections       # Ver conexiones en vivo"
    Write-Host "  .\monitor.ps1 -mode activity          # Ver actividades en vivo"
    Write-Host ""
}

# Validar que existen los logs
if (-not (Test-Path "logs/connections.log") -and $mode -ne "help") {
    Write-Host "⚠️  ADVERTENCIA: No se encontraron logs" -ForegroundColor Red
    Write-Host "Asegúrate de que el servidor está corriendo..." -ForegroundColor Yellow
    Write-Host "Ejecuta: npm start"
    exit 1
}

# Mostrar según modo seleccionado
switch ($mode.ToLower()) {
    "dashboard" {
        while ($true) {
            Show-Dashboard
            Start-Sleep -Seconds $refresh
        }
    }
    "connections" {
        Show-Connections
    }
    "activity" {
        Show-Activity
    }
    "students" {
        while ($true) {
            Show-TopStudents
            Write-Host "`n⏰ Próxima actualización en $refresh segundos... (Ctrl+C para salir)" -ForegroundColor Gray
            Start-Sleep -Seconds $refresh
        }
    }
    "help" {
        Show-Help
    }
    default {
        Write-Host "❌ Modo desconocido: $mode" -ForegroundColor Red
        Write-Host "Use -mode help para ver opciones"
        exit 1
    }
}
