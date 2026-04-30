@echo off
REM ========================================
REM Secure Audit Lab - Batch Launcher
REM ========================================

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════╗
echo ║  SECURE AUDIT LAB - INICIADOR              ║
echo ║  Auditoría de Código Seguro                ║
echo ╚════════════════════════════════════════════╝
echo.

REM Verificar si Node.js está instalado
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Node.js no está instalado
    echo.
    echo Descárgalo desde: https://nodejs.org/
    echo.
    pause
    exit /b 1
)

echo ✅ Node.js detectado: 
node --version
echo.

REM Verificar si existen node_modules
if not exist "node_modules" (
    echo 📦 Instalando dependencias...
    call npm install
    if errorlevel 1 (
        echo ❌ Error al instalar dependencias
        pause
        exit /b 1
    )
    echo ✅ Dependencias instaladas
    echo.
)

REM Crear carpeta logs si no existe
if not exist "logs" (
    echo 📁 Creando carpeta de logs...
    mkdir logs
)

REM Mostrar opciones
echo.
echo ¿Qué deseas hacer?
echo.
echo 1) 🚀 Iniciar servidor
echo 2) 📊 Monitoreo (Dashboard)
echo 3) 🔍 Ver logs en vivo
echo 4) 📋 Ver actividades
echo 5) 👥 Estudiantes más activos
echo 6) 🗑️  Limpiar logs
echo 7) ❌ Salir
echo.

set /p choice="Selecciona una opción (1-7): "

if "%choice%"=="1" (
    echo.
    echo 🚀 Iniciando servidor...
    echo.
    echo 📍 URL: http://localhost:3000
    echo 📊 Logs: ./logs/
    echo.
    echo Presiona Ctrl+C para detener
    echo.
    call npm start
) else if "%choice%"=="2" (
    echo.
    echo 📊 Abriendo Dashboard de Monitoreo...
    echo.
    call powershell -ExecutionPolicy Bypass -File monitor.ps1 -mode dashboard
) else if "%choice%"=="3" (
    echo.
    echo 🔍 Mostrando conexiones en vivo...
    echo Presiona Ctrl+C para detener
    echo.
    call powershell -ExecutionPolicy Bypass -File monitor.ps1 -mode connections
) else if "%choice%"=="4" (
    echo.
    echo 📋 Mostrando actividades en vivo...
    echo Presiona Ctrl+C para detener
    echo.
    call powershell -ExecutionPolicy Bypass -File monitor.ps1 -mode activity
) else if "%choice%"=="5" (
    echo.
    echo 👥 Estudiantes más activos...
    echo.
    call powershell -ExecutionPolicy Bypass -File monitor.ps1 -mode students
) else if "%choice%"=="6" (
    echo.
    set /p confirm="¿Estás seguro de que quieres borrar los logs? (S/N): "
    if /i "%confirm%"=="S" (
        del logs\connections.log >nul 2>&1
        del logs\activity.log >nul 2>&1
        echo ✅ Logs borrados
    ) else (
        echo ❌ Cancelado
    )
    pause
) else if "%choice%"=="7" (
    echo. Hasta luego!
    exit /b 0
) else (
    echo ❌ Opción no válida
    pause
    call :run_batch
)

pause
