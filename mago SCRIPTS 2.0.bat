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
mode con: cols=100 lines=38

:: Variável para controlar o fluxo do "Executar Tudo" do Menu Principal
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
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  S C R I P T S 1.3.2' -ForegroundColor DarkCyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host ''"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════════════════════════════════' -ForegroundColor DarkGray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   SISTEMA DE MANUTENCAO PRIVADO | STATUS: PRONTO PARA EVOLUCAO' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════════════════════════════════' -ForegroundColor DarkGray"
echo.

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Escolha uma opcao abaixo:' -ForegroundColor Gray"
echo.

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Limpeza Completa                      ' -ForegroundColor Green -NoNewline; Write-Host '[3] Menu de Otimizacao de Video (Por Marca)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Atualizar Programas (Winget)          ' -ForegroundColor Yellow -NoNewline; Write-Host '[4] Executar Tudo (Limpeza e Winget)' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] Criar Backup do Registro e Ponto de Restauracao ' -ForegroundColor DarkYellow -NoNewline; Write-Host '[0] Sair do Script' -ForegroundColor Red"
echo.
echo.

set /p "opcao=   >> Selecione uma Opcao: "

if "%opcao%"=="1" (set "modo_tudo=false" & goto LIMPEZA)
if "%opcao%"=="2" (set "modo_tudo=false" & goto DRIVERS)
if "%opcao%"=="3" (goto MENU_MARCAS_GPU)
if "%opcao%"=="4" (set "modo_tudo=true" & goto LIMPEZA)
if "%opcao%"=="5" (set "retorno_backup=MENU_PRINCIPAL" & goto EXEC_BACKUP_REG)
if "%opcao%"=="0" goto SAIR

goto MENU


:LIMPEZA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Limpando sistema...' -ForegroundColor Yellow"
for /f "delims=" %%F in ('dir /b /a-d "%TEMP%\*" 2^>nul') do (if /i not "%%F"=="mago_exec.bat" del /f /q "%TEMP%\%%F" >nul 2>&1)
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1
PowerShell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
ipconfig /flushdns >nul 2>&1
sfc /scannow
if "%modo_tudo%"=="true" goto DRIVERS
goto FIM

:DRIVERS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Atualizando via Winget...' -ForegroundColor Yellow"
winget upgrade --all --accept-source-agreements --accept-package-agreements
goto FIM

:MENU_MARCAS_GPU
cls
echo    [1] AMD | [2] NVIDIA | [3] INTEL | [9] Backup e Restauracao | [0] Voltar
set /p "marca_op=   >> Selecione: "
if "%marca_op%"=="1" goto SUBMENU_AMD
if "%marca_op%"=="2" goto SUBMENU_NVIDIA
if "%marca_op%"=="3" goto SUBMENU_INTEL
if "%marca_op%"=="9" (set "retorno_backup=MENU_MARCAS_GPU" & goto EXEC_BACKUP_REG)
goto MENU

:SUBMENU_AMD
echo AMD... (Inserir lógica aqui)
pause & goto MENU_MARCAS_GPU

:SUBMENU_NVIDIA
echo NVIDIA... (Inserir lógica aqui)
pause & goto MENU_MARCAS_GPU

:SUBMENU_INTEL
echo INTEL... (Inserir lógica aqui)
pause & goto MENU_MARCAS_GPU

:EXEC_BACKUP_REG
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Criando backup do registro...' -ForegroundColor Yellow"
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set "dt=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2!_!datetime:~8,2!h!datetime:~10,2!m"
set "p_mago=C:\Backup_MagoScripts_!dt!"
mkdir "!p_mago!" >nul 2>&1
reg export HKLM "!p_mago!\HKLM.reg" /y >nul 2>&1
reg export HKCU "!p_mago!\HKCU.reg" /y >nul 2>&1

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Abrindo Ponto de Restauracao do Windows...' -ForegroundColor Yellow"
:: Comando nativo do Windows para abrir Proteção do Sistema
start sysdm.cpl ,4
echo.
echo  Pressione qualquer tecla para retornar ao menu...
pause >nul
if "%retorno_backup%"=="MENU_PRINCIPAL" goto MENU
goto MENU_MARCAS_GPU

:FIM
echo Tudo pronto!
pause & goto MENU

:SAIR
exit
