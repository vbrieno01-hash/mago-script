@echo off
setlocal enabledelayedexpansion

:: --- CORREÇÃO DE CARACTERES (UTF-8) ---
chcp 65001 >nul

:: --- VERIFICACAO DE PRIVILEGIOS REAL ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ════════════════════════════════════════════════════════════
    echo  [!] ERRO: Precisa de executar este script como Administrador!
    echo ════════════════════════════════════════════════════════════
    pause
    exit /b
)

title MAGO SCRIPTS - Central de Manutencao
mode con: cols=100 lines=40

:: Variável para controlar o fluxo do "Executar Tudo"
set "modo_tudo=false"

:: --- MOVE O SCRIPT PARA PASTA SEGURA ANTES DE QUALQUER LIMPEZA ---
set "script_seguro=C:\Windows\Temp\mago_exec.bat"
if not "%~f0"=="%script_seguro%" (
    copy /y "%~f0" "%script_seguro%" >nul 2>&1
    call "%script_seguro%"
    exit /b
)

:MENU
cls
color 00

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ███╗   ███╗ █████╗  ██████╗  ██████╗ ' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ████╗ ████║██╔══██╗██╔════╝ ██╔═══██╗' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ██╔████╔██║███████║██║  ███╗██║   ██║' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ██║╚██╔╝██║██╔══██║██║   ██║██║   ██║' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ██║ ╚═╝ ██║██║  ██║╚██████╔╝╚██████╔╝' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  S C R I P T S 1.2.0' -ForegroundColor DarkCyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host ''"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════════════════════════════════' -ForegroundColor DarkGray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   SISTEMA DE MANUTENCAO PRIVADO | STATUS: PRONTO PARA EVOLUCAO' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════════════════════════════════' -ForegroundColor DarkGray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host ''"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Escolha uma opcao abaixo:' -ForegroundColor Gray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Limpeza Completa' -ForegroundColor White"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Atualizar Programas (Winget)' -ForegroundColor White"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Executar Tudo' -ForegroundColor Magenta"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Sair' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host ''"

set /p "opcao=   >> Opcao: "

if "%opcao%"=="1" (set "modo_tudo=false" & goto LIMPEZA)
if "%opcao%"=="2" (set "modo_tudo=false" & goto DRIVERS)
if "%opcao%"=="3" (set "modo_tudo=true" & goto LIMPEZA)
if "%opcao%"=="0" goto SAIR

goto MENU


:: ==========================================
::              LIMPEZA COMPLETA
:: ==========================================
:LIMPEZA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   MODO: LIMPEZA COMPLETA DO SISTEMA' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"

:: 1. Limpeza de Temporários do Usuário — EXCETO arquivos mago_* em uso
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Limpando arquivos temporarios do usuario...' -ForegroundColor Yellow"
for /f "delims=" %%F in ('dir /b /a-d "%TEMP%\*" 2^>nul') do (
    if /i not "%%F"=="mago_exec.bat" (
        del /f /q "%TEMP%\%%F" >nul 2>&1
    )
)
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] TEMP do usuario limpa.' -ForegroundColor Green"

:: 2. Limpeza de Temporários do Windows — EXCETO mago_exec.bat
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Limpando Windows Temp e Prefetch...' -ForegroundColor Yellow"
for /f "delims=" %%F in ('dir /b /a-d "C:\Windows\Temp\*" 2^>nul') do (
    if /i not "%%F"=="mago_exec.bat" (
        del /f /q "C:\Windows\Temp\%%F" >nul 2>&1
    )
)
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" >nul 2>&1
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Windows Temp e Prefetch limpos.' -ForegroundColor Green"

:: 3. Logs e Dumps
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Removendo logs e dumps de erro...' -ForegroundColor Yellow"
del /f /s /q "%LocalAppData%\CrashDumps\*" >nul 2>&1
del /f /s /q "C:\Windows\Minidump\*" >nul 2>&1
del /f /s /q "C:\Windows\Logs\CBS\*.log" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Logs e dumps removidos.' -ForegroundColor Green"

:: 4. Esvaziar Lixeira
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Esvaziando a Lixeira...' -ForegroundColor Yellow"
PowerShell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Lixeira esvaziada.' -ForegroundColor Green"

:: 5. Flush DNS
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Limpando Cache de DNS...' -ForegroundColor Yellow"
ipconfig /flushdns >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] DNS limpo.' -ForegroundColor Green"

:: 6. Windows Update Cache
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Resetando Cache do Windows Update...' -ForegroundColor Yellow"
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /s /q "%windir%\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%i in ("%windir%\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Cache do Windows Update limpo.' -ForegroundColor Green"

:: 7. SFC
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando SFC Scannow (Integridade)...' -ForegroundColor Yellow"
sfc /scannow

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Bloco de limpeza concluido com sucesso!' -ForegroundColor Green"
timeout /t 3 >nul

if "%modo_tudo%"=="true" goto DRIVERS
goto FIM


:: ==========================================
::         ATUALIZAR DRIVERS E PROGRAMAS
:: ==========================================
:DRIVERS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ════════════════════════════════════════' -ForegroundColor Magenta"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   MODO: ATUALIZACAO DE PROGRAMAS (WINGET)' -ForegroundColor Magenta"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ════════════════════════════════════════' -ForegroundColor Magenta"

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Atualizando aplicacoes via Winget...' -ForegroundColor Yellow"
winget upgrade --all --accept-source-agreements --accept-package-agreements

goto FIM


:FIM
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host ''"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ════════════════════════════════════════════' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   TUDO PRONTO, MAGO!' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ════════════════════════════════════════════' -ForegroundColor Green"
echo ""
pause
goto MENU

:SAIR
exit
