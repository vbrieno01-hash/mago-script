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
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  S C R I P T S 1.3.3' -ForegroundColor DarkCyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host ''"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════════════════════════════════' -ForegroundColor DarkGray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   SISTEMA DE MANUTENCAO PRIVADO | STATUS: PRONTO PARA EVOLUCAO' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════════════════════════════════' -ForegroundColor DarkGray"
echo.

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Escolha uma opcao abaixo:' -ForegroundColor Gray"
echo.

:: --- INTERFACE LADO A LADO COM CORES ---
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Limpeza Completa                      ' -ForegroundColor Green -NoNewline; Write-Host '[3] Menu de Otimizacao de Video (Por Marca)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Atualizar Programas (Winget)          ' -ForegroundColor Yellow -NoNewline; Write-Host '[4] Executar Tudo (Limpeza e Winget)' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Sair do Script' -ForegroundColor Red"
echo.
echo.

set /p "opcao=   >> Selecione uma Opcao: "

if "%opcao%"=="1" (set "modo_tudo=false" & goto LIMPEZA)
if "%opcao%"=="2" (set "modo_tudo=false" & goto DRIVERS)
if "%opcao%"=="3" (goto MENU_MARCAS_GPU)
if "%opcao%"=="4" (set "modo_tudo=true" & goto LIMPEZA)
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
echo.

:: 1. Limpeza de Temporários do Usuário
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Limpando arquivos temporarios do usuario...' -ForegroundColor Yellow"
for /f "delims=" %%F in ('dir /b /a-d "%TEMP%\*" 2^>nul') do (
    if /i not "%%F"=="mago_exec.bat" (
        del /f /q "%TEMP%\%%F" >nul 2>&1
    )
)
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] TEMP do usuario limpa.' -ForegroundColor Green"

:: 2. Limpeza de Temporários do Windows
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

echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Bloco de limpeza concluido com sucesso!' -ForegroundColor Green"
timeout /t 2 >nul

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
echo.

PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Atualizando aplicacoes via Winget...' -ForegroundColor Yellow"
winget upgrade --all --accept-source-agreements --accept-package-agreements

timeout /t 2 >nul
goto FIM


:: ==========================================
::      SUBMENU SELEÇÃO DE MARCAS
:: ==========================================
:MENU_MARCAS_GPU
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   SELECIONE A MARCA DO SEU HARDWARE DE VIDEO' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Painel de Tweaks AMD Radeon' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Painel de Tweaks NVIDIA GeForce' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Painel de Tweaks Intel Graphics' -ForegroundColor Blue"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar ao Menu Principal' -ForegroundColor Gray"
echo.
echo.

set /p "marca_op=   >> Selecione uma Opcao: "

if "%marca_op%"=="1" goto SUBMENU_AMD
if "%marca_op%"=="2" goto SUBMENU_NVIDIA
if "%marca_op%"=="3" goto SUBMENU_INTEL
if "%marca_op%"=="0" goto MENU
goto MENU_MARCAS_GPU


:: ==========================================
::         SUBMENU 1: PAINEL AMD RADEON
:: ==========================================
:SUBMENU_AMD
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   TWEAKS E OTIMIZACOES PARA AMD RADEON' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Baixar Driver Atualizado da AMD' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Desativar AMD Crash Defender' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Desativar AMD Overlay e Telemetria' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [4] Desativar ULPS (Stuttering e Clocks instaveis)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] Forcar Shader Cache Sempre Ativo' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Selecao de Marcas' -ForegroundColor Gray"
echo.
echo.

set /p "amd_op=   >> Selecione uma Opcao: "

if "%amd_op%"=="1" goto TWEAK_AMD_1
if "%amd_op%"=="2" goto TWEAK_AMD_2
if "%amd_op%"=="3" goto TWEAK_AMD_3
if "%amd_op%"=="4" goto TWEAK_AMD_4
if "%amd_op%"=="5" goto TWEAK_AMD_5
if "%amd_op%"=="0" goto MENU_MARCAS_GPU
goto SUBMENU_AMD

:TWEAK_AMD_1
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Abrindo site para Baixar Driver AMD...' -ForegroundColor Yellow"
start https://www.amd.com/pt/support/download/drivers.html
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_2
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar AMD Crash Defender...' -ForegroundColor Yellow"
sc stop "AMD Crash Defender Service" >nul 2>&1
sc config "AMD Crash Defender Service" start= disabled >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Servico Crash Defender Desativado!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_3
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar AMD Overlay e Telemetria...' -ForegroundColor Yellow"
reg add "HKLM\SOFTWARE\AMD\CN" /v "AllowWebContent" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria e Overlay AMD Desativados!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_4
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar ULPS...' -ForegroundColor Yellow"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableUlps" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableUlps_NA" /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] ULPS Desativado!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_5
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Forcar Shader Cache sempre ativo...' -ForegroundColor Yellow"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "ShaderCache" /t REG_DWORD /d 2 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Shader Cache travado em Sempre Ativo!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_AMD


:: ==========================================
::        SUBMENU 2: PAINEL NVIDIA GEFORCE
:: ==========================================
:SUBMENU_NVIDIA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   TWEAKS E OTIMIZACOES PARA NVIDIA GEFORCE' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Baixar Driver Oficial Atualizado da NVIDIA' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Desativar Telemetria NVIDIA (Serviços)' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Limpar Cache de Shaders NVIDIA (DXCache/GLCache)' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [4] Desativar NVIDIA ShadowPlay' -ForegroundColor DarkCyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] Desativar Hardware Accelerated GPU Scheduling (HAGS)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [6] Desativar MPO (Multi-Plane Overlay)' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [A] APLICAR TODOS OS TWEAKS NVIDIA DE UMA VEZ' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Selecao de Marcas' -ForegroundColor Gray"
echo.
echo.

set /p "nv_op=   >> Selecione uma Opcao: "

if "%nv_op%"=="1" goto TWEAK_NV_1
if "%nv_op%"=="2" goto TWEAK_NV_2
if "%nv_op%"=="3" goto TWEAK_NV_3
if "%nv_op%"=="4" goto TWEAK_NV_4
if "%nv_op%"=="5" goto TWEAK_NV_5
if "%nv_op%"=="6" goto TWEAK_NV_6
if /i "%nv_op%"=="A" goto OTIMIZAR_TUDO_NVIDIA
if "%nv_op%"=="0" goto MENU_MARCAS_GPU
goto SUBMENU_NVIDIA

:TWEAK_NV_1
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Abrindo site para Baixar Driver NVIDIA...' -ForegroundColor Yellow"
start https://www.nvidia.com/pt-br/drivers/
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_2
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativando telemetria NVIDIA...' -ForegroundColor Yellow"
sc stop NvTelemetryContainer >nul 2>&1
sc config NvTelemetryContainer start= disabled >nul 2>&1
sc stop NVDisplay.ContainerLocalSystem >nul 2>&1
sc config NVDisplay.ContainerLocalSystem start= auto >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria Desativada com sucesso!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_3
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Limpando Shader Cache NVIDIA...' -ForegroundColor Yellow"
del /s /f /q "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Limpeza de Cache Concluida!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_4
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar NVIDIA ShadowPlay...' -ForegroundColor Yellow"
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\ShadowPlay" /v "Allow" /t REG_DWORD /d 0 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] ShadowPlay Desativado!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_5
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar HAGS...' -ForegroundColor Yellow"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] HAGS Desativado!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_6
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar MPO...' -ForegroundColor Yellow"
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] MPO Desativado!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:OTIMIZAR_TUDO_NVIDIA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Aplicando TODOS os tweaks NVIDIA de forma segura...' -ForegroundColor Yellow"
sc stop NvTelemetryContainer >nul 2>&1
sc config NvTelemetryContainer start= disabled >nul 2>&1
sc stop NVDisplay.ContainerLocalSystem >nul 2>&1
sc config NVDisplay.ContainerLocalSystem start= auto >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1
reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\ShadowPlay" /v "Allow" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Bloco completo da NVIDIA configurado!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA


:: ==========================================
::         SUBMENU 3: PAINEL INTEL GRAPHICS
:: ==========================================
:SUBMENU_INTEL
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Blue"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   TWEAKS E OTIMIZACOES PARA INTEL GRAPHICS / CPU' -ForegroundColor Blue"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Blue"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Baixar Driver Central de Downloads Intel' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Otimizar Timers e Prioridade de Processamento' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Selecao de Marcas' -ForegroundColor Gray"
echo.
echo.

set /p "intel_op=   >> Selecione uma Opcao: "

if "%intel_op%"=="1" goto TWEAK_INTEL_1
if "%intel_op%"=="2" goto TWEAK_INTEL_2
if "%intel_op%"=="0" goto MENU_MARCAS_GPU
goto SUBMENU_INTEL

:TWEAK_INTEL_1
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Abrindo site para Central de Downloads da Intel...' -ForegroundColor Yellow"
start https://www.intel.com.br/content/www/br/pt/download-center/home.html
timeout /t 2 >nul
goto SUBMENU_INTEL

:TWEAK_INTEL_2
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Aplicando Prioridade de System (Gaming)...' -ForegroundColor Yellow"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Otimizando Timers de Latencia...' -ForegroundColor Yellow"
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Tweaks de Performance Intel Aplicados!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_INTEL


:: ==========================================
::                TELA FINAL
:: ==========================================
:FIM
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ════════════════════════════════════════════' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   TUDO PRONTO, MAGO!' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ════════════════════════════════════════════' -ForegroundColor Green"
echo.
pause
goto MENU

:SAIR
exit
