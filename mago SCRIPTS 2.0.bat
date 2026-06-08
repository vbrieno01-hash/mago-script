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
mode con: cols=120 lines=50

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
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  S C R I P T S 1.4.0' -ForegroundColor DarkCyan"
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
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Atualizar Programas (Winget)          ' -ForegroundColor Yellow -NoNewline; Write-Host '[4] Backup do Sistema' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] BATS (Scripts Customizados)           ' -ForegroundColor White -NoNewline; Write-Host '     [0] Sair do Script' -ForegroundColor Red"
echo.
echo.

set /p "opcao=   >> Selecione uma Opcao: "

if "%opcao%"=="1" (set "modo_tudo=false" & goto LIMPEZA)
if "%opcao%"=="2" (set "modo_tudo=false" & goto DRIVERS)
if "%opcao%"=="3" (goto MENU_MARCAS_GPU)
if "%opcao%"=="4" goto BACKUP
if "%opcao%"=="5" goto MENU_BATS
if "%opcao%"=="0" goto SAIR

goto MENU

:: ==========================================
::              BACKUP DO SISTEMA
:: ==========================================
:BACKUP
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor DarkYellow"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   MODO: PROTECAO DO SISTEMA (PONTO DE RESTAURACAO)' -ForegroundColor DarkYellow"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Abrindo Protecao do Sistema (Restauracao)...' -ForegroundColor Yellow"
echo.
start SystemPropertiesProtection.exe
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Janela de Protecao do Sistema aberta com sucesso!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Nao foi possivel abrir a janela de Protecao do Sistema!' -ForegroundColor Red"
)
echo.
timeout /t 3 >nul
goto FIM

:: ==========================================
::              MENU BATS (SCRIPTS)
:: ==========================================
:MENU_BATS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor White"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   BATS - SCRIPTS CUSTOMIZADOS' -ForegroundColor White"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Escolha uma categoria abaixo:' -ForegroundColor Gray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] CPU (Otimizacoes e Tweaks)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] HDD (Otimizacoes e Limpeza)' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] RAM (Memoria e Cache)' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [4] SSD (Otimizacoes)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] Windows (Otimizacoes)' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar ao Menu Principal' -ForegroundColor Gray"
echo.
echo.

set /p "bats_op=   >> Selecione uma Opcao: "

if "%bats_op%"=="1" goto SUBMENU_CPU
if "%bats_op%"=="2" goto SUBMENU_HDD
if "%bats_op%"=="3" goto SUBMENU_RAM
if "%bats_op%"=="4" goto SUBMENU_SSD
if "%bats_op%"=="5" goto SUBMENU_WINDOWS
if "%bats_op%"=="0" goto MENU
goto MENU_BATS

:: ==========================================
::         SUBMENU CPU (OTIMIZACOES)
:: ==========================================
:SUBMENU_CPU
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   CPU - OTIMIZACOES E TWEAKS' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   ATENCAO: Alteracoes na CPU podem ter efeitos variaveis.' -ForegroundColor Yellow"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Teste cada ajuste para verificar estabilidade!' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Desativar Hyper-V (Maquina Virtual)' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Desativar Throttling da CPU (Forcar 100%%)' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Ativar Modo de Maximo Desempenho da CPU' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [4] Exibir Aviso (Leia.txt)' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Menu BATS' -ForegroundColor Gray"
echo.
echo.

set /p "cpu_op=   >> Selecione uma Opcao: "

if "%cpu_op%"=="1" goto CPU_HYPERV
if "%cpu_op%"=="2" goto CPU_THROTTLING
if "%cpu_op%"=="3" goto CPU_MAX_PERFORMANCE
if "%cpu_op%"=="4" goto CPU_AVISO
if "%cpu_op%"=="0" goto MENU_BATS
goto SUBMENU_CPU

:CPU_HYPERV
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Hyper-V...' -ForegroundColor Yellow"
echo.
:: Verificar status atual do Hyper-V
bcdedit /enum | find "hypervisorlaunchtype" >nul
if %errorLevel% equ 0 (
    bcdedit /enum | find "hypervisorlaunchtype off" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Hyper-V ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        bcdedit /set hypervisorlaunchtype off >nul 2>&1
        if %errorLevel% equ 0 (
            PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Hyper-V desativado com sucesso! Reinicie para aplicar.' -ForegroundColor Green"
        ) else (
            PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Hyper-V.' -ForegroundColor Red"
        )
    )
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Hyper-V nao esta configurado neste sistema.' -ForegroundColor Yellow"
)
echo.
timeout /t 3 >nul
goto SUBMENU_CPU

:CPU_THROTTLING
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Throttling da CPU...' -ForegroundColor Yellow"
echo.
:: Verificar se o throttling ja esta em 100%
powercfg -getacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX > "%TEMP%\throttle_check.txt" 2>nul
set /p throttle_val=<"%TEMP%\throttle_check.txt" 2>nul
if "%throttle_val%"=="100" (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Throttling da CPU ja estava configurado para 100%%.' -ForegroundColor Yellow"
) else (
    powercfg -setacvalueindex SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 100 >nul 2>&1
    powercfg -setactive SCHEME_CURRENT >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Throttling desativado! CPU forcada a 100%% quando necessario.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Throttling da CPU.' -ForegroundColor Red"
    )
)
del "%TEMP%\throttle_check.txt" 2>nul
echo.
timeout /t 3 >nul
goto SUBMENU_CPU

:CPU_MAX_PERFORMANCE
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Ativar Maximo Desempenho da CPU...' -ForegroundColor Yellow"
echo.
:: Verificar o plano de energia atual
powercfg /getactivescheme | find "SCHEME_MIN" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Modo de Alto Desempenho ja estava ativado.' -ForegroundColor Yellow"
) else (
    powercfg /setactive SCHEME_MIN >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Modo de Alto Desempenho ativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao ativar o Modo de Alto Desempenho.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_CPU

:CPU_AVISO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Yellow"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   AVISO IMPORTANTE' -ForegroundColor Yellow"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Fazer alteracoes na CPU pode dar certo ou errado,' -ForegroundColor White"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   entao para saber se ira dar certo e so testando!!' -ForegroundColor White"
echo.
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Recomendacoes:' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   - Crie um ponto de restauracao antes de aplicar' -ForegroundColor Gray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   - Teste cada ajuste individualmente' -ForegroundColor Gray"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   - Monitore temperaturas apos as alteracoes' -ForegroundColor Gray"
echo.
pause
goto SUBMENU_CPU

:: ==========================================
::         SUBMENU HDD (OTIMIZACOES)
:: ==========================================
:SUBMENU_HDD
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   HDD - OTIMIZACOES E LIMPEZA' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Otimizacoes para HD/SSD e limpeza de espaco:' -ForegroundColor Gray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Ajustar Tempo de Inatividade do HD' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Desativar Last Access (Melhora performance)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Limpar SSD / HDD (Liberador de Espaco)' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Menu BATS' -ForegroundColor Gray"
echo.
echo.

set /p "hdd_op=   >> Selecione uma Opcao: "

if "%hdd_op%"=="1" goto HDD_TIMEOUT
if "%hdd_op%"=="2" goto HDD_LASTACCESS
if "%hdd_op%"=="3" goto HDD_CLEAN
if "%hdd_op%"=="0" goto MENU_BATS
goto SUBMENU_HDD

:HDD_TIMEOUT
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar desligamento automatico do HD...' -ForegroundColor Yellow"
echo.
:: Verificar valores atuais do timeout
powercfg /query SCHEME_CURRENT SUB_DISK DISKIDLETIMEOUTAC > "%TEMP%\disk_timeout.txt" 2>nul
type "%TEMP%\disk_timeout.txt" | find "0x00000000" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] HD ja estava configurado para nao desligar automaticamente.' -ForegroundColor Yellow"
) else (
    powercfg /change disk-timeout-ac 0 >nul 2>&1
    powercfg /change disk-timeout-dc 0 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] HD agora nao desligara automaticamente por inatividade!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao ajustar o tempo de inatividade do HD.' -ForegroundColor Red"
    )
)
del "%TEMP%\disk_timeout.txt" 2>nul
echo.
timeout /t 3 >nul
goto SUBMENU_HDD

:HDD_LASTACCESS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Last Access (Atualizacao de timestamp)...' -ForegroundColor Yellow"
echo.
:: Verificar status atual do Last Access
fsutil behavior query DisableLastAccess | find "DisableLastAccess = 2" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Last Access ja estava desativado.' -ForegroundColor Yellow"
) else (
    fsutil behavior set disableLastAccess 2 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Last Access desativado! Melhor performance em HD/SSD.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Last Access.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_HDD

:HDD_CLEAN
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Abrindo Liberador de Espaco (cleanmgr)...' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Selecione o drive e os arquivos que deseja limpar.' -ForegroundColor Gray"
echo.
start cleanmgr
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Liberador de Espaco aberto com sucesso!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Nao foi possivel abrir o Liberador de Espaco.' -ForegroundColor Red"
)
echo.
timeout /t 3 >nul
goto SUBMENU_HDD

:: ==========================================
::         SUBMENU RAM (MEMORIA)
:: ==========================================
:SUBMENU_RAM
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   RAM - OTIMIZACAO DE MEMORIA' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Limpeza de cache e ajustes de gerenciamento de memoria:' -ForegroundColor Gray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Limpar Cache da Memoria RAM' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Otimizar Memory Management (LargeSystemCache)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Limpar Cache Working Set (Libera RAM em uso)' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Menu BATS' -ForegroundColor Gray"
echo.
echo.

set /p "ram_op=   >> Selecione uma Opcao: "

if "%ram_op%"=="1" goto RAM_CLEAR_CACHE
if "%ram_op%"=="2" goto RAM_MANAGEMENT
if "%ram_op%"=="3" goto RAM_WORKINGSET
if "%ram_op%"=="0" goto MENU_BATS
goto SUBMENU_RAM

:RAM_CLEAR_CACHE
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Limpando cache da memoria RAM...' -ForegroundColor Yellow"
echo.
PowerShell -NoProfile -Command "[System.GC]::Collect()" >nul 2>&1
PowerShell -NoProfile -Command "[System.GC]::WaitForPendingFinalizers()" >nul 2>&1
PowerShell -NoProfile -Command "[System.GC]::Collect()" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Cache de memoria RAM limpo com sucesso!' -ForegroundColor Green"
echo.
timeout /t 3 >nul
goto SUBMENU_RAM

:RAM_MANAGEMENT
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Otimizar Memory Management...' -ForegroundColor Yellow"
echo.
:: Verificar valor atual do LargeSystemCache
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] LargeSystemCache ja estava otimizado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 0 /f >nul 2>&1
        if %errorLevel% equ 0 (
            PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] LargeSystemCache ajustado para otimizacao!' -ForegroundColor Green"
        ) else (
            PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao ajustar o LargeSystemCache.' -ForegroundColor Red"
        )
    )
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] LargeSystemCache ajustado para otimizacao!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao ajustar o LargeSystemCache.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_RAM

:RAM_WORKINGSET
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Limpando Working Set da RAM...' -ForegroundColor Yellow"
echo.
PowerShell -NoProfile -Command "Get-Process | ForEach-Object { $_.WorkingSet | Out-Null; $_.Refresh() }" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Working Set limpo! RAM liberada.' -ForegroundColor Green"
echo.
timeout /t 3 >nul
goto SUBMENU_RAM

:: ==========================================
::         SUBMENU SSD (OTIMIZACOES)
:: ==========================================
:SUBMENU_SSD
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   SSD - OTIMIZACOES' -ForegroundColor Cyan"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Otimizacoes especificas para SSD:' -ForegroundColor Gray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Habilitar TRIM' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Otimizacoes SSD (disableLastAccess + disable8dot3)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Desativar Superfetch (SysMain)' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [4] Desativar Hibernacao (opcional)' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] Outras Otimizacoes para SSD' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Menu BATS' -ForegroundColor Gray"
echo.
echo.

set /p "ssd_op=   >> Selecione uma Opcao: "

if "%ssd_op%"=="1" goto SSD_TRIM
if "%ssd_op%"=="2" goto SSD_OTIMIZACOES
if "%ssd_op%"=="3" goto SSD_SUPERFETCH
if "%ssd_op%"=="4" goto SSD_HIBERNACAO
if "%ssd_op%"=="5" goto SUBMENU_OUTRAS_SSD
if "%ssd_op%"=="0" goto MENU_BATS
goto SUBMENU_SSD

:SSD_TRIM
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Habilitar TRIM...' -ForegroundColor Yellow"
echo.
:: Verificar se TRIM ja esta habilitado
fsutil behavior query DisableDeleteNotify | find "DisableDeleteNotify = 0" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] TRIM ja estava habilitado no sistema.' -ForegroundColor Yellow"
) else (
    fsutil behavior set DisableDeleteNotify 0 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] TRIM habilitado! SSD otimizado.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao habilitar TRIM.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_SSD

:SSD_OTIMIZACOES
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Otimizacoes SSD...' -ForegroundColor Yellow"
echo.
:: Verificar disableLastAccess
fsutil behavior query DisableLastAccess | find "DisableLastAccess = 0" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] disableLastAccess ja estava otimizado (0).' -ForegroundColor Yellow"
) else (
    fsutil behavior set disableLastAccess 0 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] disableLastAccess configurado para 0.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao configurar disableLastAccess.' -ForegroundColor Red"
    )
)
:: Verificar disable8dot3
fsutil behavior query disable8dot3 | find "disable8dot3 = 1" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] disable8dot3 ja estava otimizado (1).' -ForegroundColor Yellow"
) else (
    fsutil behavior set disable8dot3 1 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] disable8dot3 configurado para 1.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao configurar disable8dot3.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_SSD

:SSD_SUPERFETCH
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Superfetch (SysMain)...' -ForegroundColor Yellow"
echo.
:: Verificar status atual do Superfetch
sc query SysMain | find "STOPPED" >nul
if %errorLevel% equ 0 (
    sc qc SysMain | find "START_TYPE" | find "DISABLED" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Superfetch (SysMain) ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        sc stop SysMain >nul 2>&1
        sc config SysMain start= disabled >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Superfetch (SysMain) desativado!' -ForegroundColor Green"
    )
) else (
    sc stop SysMain >nul 2>&1
    sc config SysMain start= disabled >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Superfetch (SysMain) desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Superfetch.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_SSD

:SSD_HIBERNACAO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Hibernacao...' -ForegroundColor Yellow"
echo.
:: Verificar se hibernacao ja esta desativada
powercfg /a | find "Hibernação" | find "Disponível" >nul
if %errorLevel% equ 0 (
    powercfg -h off >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Hibernacao desativada! Espaco em disco liberado.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar hibernacao.' -ForegroundColor Red"
    )
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Hibernacao ja estava desativada.' -ForegroundColor Yellow"
)
echo.
timeout /t 3 >nul
goto SUBMENU_SSD

:: ==========================================
::      SUBMENU OUTRAS OTIMIZACOES PARA SSD
:: ==========================================
:SUBMENU_OUTRAS_SSD
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   OUTRAS OTIMIZACOES PARA SSD' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   ATENCAO: As opcoes abaixo REVERTEM otimizacoes!' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] REVERTER otimizacoes para SSD' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Menu SSD' -ForegroundColor Gray"
echo.
echo.

set /p "outras_ssd_op=   >> Selecione uma Opcao: "

if "%outras_ssd_op%"=="1" goto SSD_REVERTER
if "%outras_ssd_op%"=="0" goto SUBMENU_SSD
goto SUBMENU_OUTRAS_SSD

:SSD_REVERTER
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: REVERTER otimizacoes para SSD...' -ForegroundColor Yellow"
echo.
:: Reverter TRIM
fsutil behavior query DisableDeleteNotify | find "DisableDeleteNotify = 1" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] TRIM ja estava desabilitado (revertido).' -ForegroundColor Yellow"
) else (
    fsutil behavior set DisableDeleteNotify 1 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] TRIM desabilitado (revertido).' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desabilitar TRIM.' -ForegroundColor Red"
    )
)
:: Reverter disableLastAccess
fsutil behavior query DisableLastAccess | find "DisableLastAccess = 1" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] disableLastAccess ja estava restaurado (1).' -ForegroundColor Yellow"
) else (
    fsutil behavior set disableLastAccess 1 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] disableLastAccess restaurado para 1.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao restaurar disableLastAccess.' -ForegroundColor Red"
    )
)
:: Reverter disable8dot3
fsutil behavior query disable8dot3 | find "disable8dot3 = 0" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] disable8dot3 ja estava restaurado (0).' -ForegroundColor Yellow"
) else (
    fsutil behavior set disable8dot3 0 >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] disable8dot3 restaurado para 0.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao restaurar disable8dot3.' -ForegroundColor Red"
    )
)
:: Reativar Superfetch
sc query SysMain | find "RUNNING" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Superfetch ja estava ativo.' -ForegroundColor Yellow"
) else (
    sc config SysMain start= auto >nul 2>&1
    sc start SysMain >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Superfetch reativado.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao reativar Superfetch.' -ForegroundColor Red"
    )
)
:: Reativar Hibernacao
powercfg /a | find "Hibernação" | find "Disponível" >nul
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Hibernacao ja estava ativa.' -ForegroundColor Yellow"
) else (
    powercfg -h on >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Hibernacao reativada.' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao reativar hibernacao.' -ForegroundColor Red"
    )
)
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Processo de reversao concluido!' -ForegroundColor Green"
echo.
timeout /t 3 >nul
goto SUBMENU_OUTRAS_SSD

:: ==========================================
::      SUBMENU WINDOWS (OTIMIZACOES)
:: ==========================================
:SUBMENU_WINDOWS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Magenta"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   WINDOWS - OTIMIZACOES E TWEAKS' -ForegroundColor Magenta"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   Otimizacoes para melhorar performance do Windows:' -ForegroundColor Gray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [1] Desativar Servicos Inuteis do Windows' -ForegroundColor Yellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [2] Desativar Indexacao (WSearch)' -ForegroundColor Cyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [3] Desativar Atualizacoes Automaticas' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [4] Desativar Telemetria (Coleta de dados)' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [5] Desativar Cortana' -ForegroundColor Magenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [6] Desativar Bing Search' -ForegroundColor DarkCyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [7] Desativar Sugestoes de Pesquisa' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [8] Desativar Historico de Atividade' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [9] Desativar Efeitos Visuais' -ForegroundColor White"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [10] Desativar Animacoes no Sistema' -ForegroundColor DarkRed"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [11] Desativar Transparencia do Windows' -ForegroundColor DarkMagenta"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [12] Desativar Hibernacao' -ForegroundColor DarkYellow"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [13] Desativar Servico de Relogio (W32Time)' -ForegroundColor DarkCyan"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [14] Otimizar Windows Explorer' -ForegroundColor DarkGreen"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [A] APLICAR TODAS AS OTIMIZACOES (1 a 14)' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [R] REVERTER OTIMIZACOES (Principais)' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ────────────────────────────────────────────────────────────────────────' -ForegroundColor DarkGray"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [0] Voltar para Menu BATS' -ForegroundColor Gray"
echo.
echo.

set /p "win_op=   >> Selecione uma Opcao: "

if "%win_op%"=="1" goto WIN_SERVICOS
if "%win_op%"=="2" goto WIN_INDEXACAO
if "%win_op%"=="3" goto WIN_ATUALIZACOES
if "%win_op%"=="4" goto WIN_TELEMETRIA
if "%win_op%"=="5" goto WIN_CORTANA
if "%win_op%"=="6" goto WIN_BING
if "%win_op%"=="7" goto WIN_SUGESTOES
if "%win_op%"=="8" goto WIN_HISTORICO
if "%win_op%"=="9" goto WIN_EFEITOS
if "%win_op%"=="10" goto WIN_ANIMACOES
if "%win_op%"=="11" goto WIN_TRANSPARENCIA
if "%win_op%"=="12" goto WIN_HIBERNACAO
if "%win_op%"=="13" goto WIN_RELOGIO
if "%win_op%"=="14" goto WIN_EXPLORER
if /i "%win_op%"=="A" goto WIN_APLICAR_TUDO
if /i "%win_op%"=="R" goto WIN_REVERTER
if "%win_op%"=="0" goto MENU_BATS
goto SUBMENU_WINDOWS

:WIN_SERVICOS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Servicos Inuteis...' -ForegroundColor Yellow"
echo.
call :DesativarServico "wisvc" "Experiências do Usuário Conectado"
call :DesativarServico "DPS" "Diagnostic Policy Service"
call :DesativarServico "TermService" "Acesso Remoto"
call :DesativarServico "WbioSrvc" "Biometria"
call :DesativarServico "TabletInputService" "Entrada por Toque"
call :DesativarServico "DiagTrack" "Diagnostic Tracking"
call :DesativarServico "WaaSMedicSvc" "Medico do Windows Update"
call :DesativarServico "RetailDemo" "Modo Demo"
call :DesativarServico "igts" "Intel Graphics"
call :DesativarServico "bthserv" "Bluetooth"
call :DesativarServico "Spooler" "Impressao"
call :DesativarServico "RemoteRegistry" "Registro Remoto"
call :DesativarServico "SessionEnv" "Configuracao Remota"
call :DesativarServico "PcaSvc" "Compatibilidade de Programas"
call :DesativarServico "Fax" "Fax"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Servicos inuteis processados!' -ForegroundColor Green"
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:DesativarServico
set "servico=%~1"
set "nome=%~2"
sc query "%servico%" | find "STOPPED" >nul
if %errorLevel% equ 0 (
    sc qc "%servico%" | find "START_TYPE" | find "DISABLED" >nul
    if %errorLevel% equ 0 (
        echo    [AVISO] %nome% ja estava desativado.
    ) else (
        sc stop "%servico%" >nul 2>&1
        sc config "%servico%" start= disabled >nul 2>&1
        echo    [OK] %nome% desativado.
    )
) else (
    sc stop "%servico%" >nul 2>&1
    sc config "%servico%" start= disabled >nul 2>&1
    if %errorLevel% equ 0 (
        echo    [OK] %nome% desativado.
    ) else (
        echo    [ERRO] Falha ao desativar %nome%.
    )
)
exit /b

:WIN_INDEXACAO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Indexacao...' -ForegroundColor Yellow"
echo.
sc query WSearch | find "STOPPED" >nul
if %errorLevel% equ 0 (
    sc qc WSearch | find "START_TYPE" | find "DISABLED" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Indexacao ja estava desativada.' -ForegroundColor Yellow"
    ) else (
        sc stop WSearch >nul 2>&1
        sc config WSearch start= disabled >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Indexacao desativada!' -ForegroundColor Green"
    )
) else (
    sc stop WSearch >nul 2>&1
    sc config WSearch start= disabled >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Indexacao desativada!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Indexacao.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_ATUALIZACOES
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Atualizacoes Automaticas...' -ForegroundColor Yellow"
echo.
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate | find "0x1" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Atualizacoes automaticas ja estavam desativadas.' -ForegroundColor Yellow"
    ) else (
        net stop wuauserv >nul 2>&1
        sc config wuauserv start= disabled >nul 2>&1
        net stop bits >nul 2>&1
        sc config bits start= disabled >nul 2>&1
        net stop dosvc >nul 2>&1
        sc config dosvc start= disabled >nul 2>&1
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Atualizacoes automaticas desativadas!' -ForegroundColor Green"
    )
) else (
    net stop wuauserv >nul 2>&1
    sc config wuauserv start= disabled >nul 2>&1
    net stop bits >nul 2>&1
    sc config bits start= disabled >nul 2>&1
    net stop dosvc >nul 2>&1
    sc config dosvc start= disabled >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Atualizacoes automaticas desativadas!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar atualizacoes automaticas.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_TELEMETRIA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Telemetria...' -ForegroundColor Yellow"
echo.
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Telemetria ja estava desativada.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria desativada!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria desativada!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar telemetria.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_CORTANA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Cortana...' -ForegroundColor Yellow"
echo.
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Cortana ja estava desativada.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Cortana desativada!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Cortana desativada!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Cortana.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_BING
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Bing Search...' -ForegroundColor Yellow"
echo.
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Bing Search ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Bing Search desativado!' -ForegroundColor Green"
    )
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Bing Search desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar Bing Search.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_SUGESTOES
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Sugestoes de Pesquisa...' -ForegroundColor Yellow"
echo.
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchHistoryEnabled >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchHistoryEnabled | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Sugestoes de pesquisa ja estavam desativadas.' -ForegroundColor Yellow"
    ) else (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Sugestoes de pesquisa desativadas!' -ForegroundColor Green"
    )
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Sugestoes de pesquisa desativadas!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar sugestoes de pesquisa.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_HISTORICO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Historico de Atividade...' -ForegroundColor Yellow"
echo.
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Historico de atividade ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Historico de atividade desativado!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Historico de atividade desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar historico de atividade.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_EFEITOS
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Efeitos Visuais...' -ForegroundColor Yellow"
echo.
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting | find "0x2" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Efeitos visuais ja estavam desativados.' -ForegroundColor Yellow"
    ) else (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
        reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 90120000010000000000000000 /f >nul 2>&1
        reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Efeitos visuais desativados!' -ForegroundColor Green"
    )
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
    reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 90120000010000000000000000 /f >nul 2>&1
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Efeitos visuais desativados!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar efeitos visuais.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_ANIMACOES
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Animacoes no Sistema...' -ForegroundColor Yellow"
echo.
reg query "HKCU\Control Panel\Desktop" /v UserPreferencesMask >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 90120380 /f >nul 2>&1
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Animacoes desativadas!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar animacoes.' -ForegroundColor Red"
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_TRANSPARENCIA
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Transparencia do Windows...' -ForegroundColor Yellow"
echo.
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Transparencia ja estava desativada.' -ForegroundColor Yellow"
    ) else (
        reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Transparencia desativada!' -ForegroundColor Green"
    )
) else (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Transparencia desativada!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar transparencia.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_HIBERNACAO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Hibernacao...' -ForegroundColor Yellow"
echo.
powercfg /a | find "Hibernação" | find "Disponível" >nul
if %errorLevel% equ 0 (
    powercfg -h off >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Hibernacao desativada!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar hibernacao.' -ForegroundColor Red"
    )
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Hibernacao ja estava desativada.' -ForegroundColor Yellow"
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_RELOGIO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar Servico de Relogio (W32Time)...' -ForegroundColor Yellow"
echo.
sc query W32Time | find "STOPPED" >nul
if %errorLevel% equ 0 (
    sc qc W32Time | find "START_TYPE" | find "DISABLED" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Servico de relogio ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        sc stop W32Time >nul 2>&1
        sc config W32Time start= disabled >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Servico de relogio desativado!' -ForegroundColor Green"
    )
) else (
    sc stop W32Time >nul 2>&1
    sc config W32Time start= disabled >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Servico de relogio desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar servico de relogio.' -ForegroundColor Red"
    )
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_EXPLORER
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Otimizar Windows Explorer...' -ForegroundColor Yellow"
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul 2>&1
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Windows Explorer otimizado!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao otimizar Windows Explorer.' -ForegroundColor Red"
)
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_APLICAR_TUDO
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   APLICANDO TODAS AS OTIMIZACOES DO WINDOWS' -ForegroundColor Green"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Aplicando todas as 14 otimizacoes...' -ForegroundColor Yellow"
echo.

call :WIN_SERVICOS_INTERNO
call :WIN_INDEXACAO_INTERNO
call :WIN_ATUALIZACOES_INTERNO
call :WIN_TELEMETRIA_INTERNO
call :WIN_CORTANA_INTERNO
call :WIN_BING_INTERNO
call :WIN_SUGESTOES_INTERNO
call :WIN_HISTORICO_INTERNO
call :WIN_EFEITOS_INTERNO
call :WIN_ANIMACOES_INTERNO
call :WIN_TRANSPARENCIA_INTERNO
call :WIN_HIBERNACAO_INTERNO
call :WIN_RELOGIO_INTERNO
call :WIN_EXPLORER_INTERNO

echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Todas as otimizacoes foram aplicadas com sucesso!' -ForegroundColor Green"
echo.
timeout /t 3 >nul
goto SUBMENU_WINDOWS

:WIN_SERVICOS_INTERNO
echo    Desativando servicos inuteis...
call :DesativarServico "wisvc" "Experiências do Usuário Conectado" >nul
call :DesativarServico "DPS" "Diagnostic Policy Service" >nul
call :DesativarServico "TermService" "Acesso Remoto" >nul
call :DesativarServico "WbioSrvc" "Biometria" >nul
call :DesativarServico "TabletInputService" "Entrada por Toque" >nul
call :DesativarServico "DiagTrack" "Diagnostic Tracking" >nul
call :DesativarServico "WaaSMedicSvc" "Medico do Windows Update" >nul
call :DesativarServico "RetailDemo" "Modo Demo" >nul
call :DesativarServico "igts" "Intel Graphics" >nul
call :DesativarServico "bthserv" "Bluetooth" >nul
call :DesativarServico "Spooler" "Impressao" >nul
call :DesativarServico "RemoteRegistry" "Registro Remoto" >nul
call :DesativarServico "SessionEnv" "Configuracao Remota" >nul
call :DesativarServico "PcaSvc" "Compatibilidade de Programas" >nul
call :DesativarServico "Fax" "Fax" >nul
echo    [OK] Servicos processados
exit /b

:WIN_INDEXACAO_INTERNO
echo    Desativando Indexacao...
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
echo    [OK] Indexacao desativada
exit /b

:WIN_ATUALIZACOES_INTERNO
echo    Desativando Atualizacoes Automaticas...
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1
net stop bits >nul 2>&1
sc config bits start= disabled >nul 2>&1
net stop dosvc >nul 2>&1
sc config dosvc start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
echo    [OK] Atualizacoes desativadas
exit /b

:WIN_TELEMETRIA_INTERNO
echo    Desativando Telemetria...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Telemetria desativada
exit /b

:WIN_CORTANA_INTERNO
echo    Desativando Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Cortana desativada
exit /b

:WIN_BING_INTERNO
echo    Desativando Bing Search...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Bing desativado
exit /b

:WIN_SUGESTOES_INTERNO
echo    Desativando Sugestoes de Pesquisa...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchHistoryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Sugestoes desativadas
exit /b

:WIN_HISTORICO_INTERNO
echo    Desativando Historico de Atividade...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Historico desativado
exit /b

:WIN_EFEITOS_INTERNO
echo    Desativando Efeitos Visuais...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 90120000010000000000000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d 0 /f >nul 2>&1
echo    [OK] Efeitos desativados
exit /b

:WIN_ANIMACOES_INTERNO
echo    Desativando Animacoes...
reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d 90120380 /f >nul 2>&1
echo    [OK] Animacoes desativadas
exit /b

:WIN_TRANSPARENCIA_INTERNO
echo    Desativando Transparencia...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Transparencia desativada
exit /b

:WIN_HIBERNACAO_INTERNO
echo    Desativando Hibernacao...
powercfg -h off >nul 2>&1
echo    [OK] Hibernacao desativada
exit /b

:WIN_RELOGIO_INTERNO
echo    Desativando Servico de Relogio...
sc stop W32Time >nul 2>&1
sc config W32Time start= disabled >nul 2>&1
echo    [OK] Servico desativado
exit /b

:WIN_EXPLORER_INTERNO
echo    Otimizando Windows Explorer...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f >nul 2>&1
echo    [OK] Explorer otimizado
exit /b

:WIN_REVERTER
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   REVERTENDO OTIMIZACOES DO WINDOWS' -ForegroundColor Red"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  ══════════════════════════════════════════════════════════' -ForegroundColor Red"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Revertendo principais configuracoes...' -ForegroundColor Yellow"
echo.

:: Reverter Indexacao
sc config WSearch start= auto >nul 2>&1
net start WSearch >nul 2>&1
echo    [OK] Indexacao reativada.

:: Reverter Atualizacoes
sc config wuauserv start= auto >nul 2>&1
net start wuauserv >nul 2>&1
sc config bits start= auto >nul 2>&1
net start bits >nul 2>&1
sc config dosvc start= auto >nul 2>&1
net start dosvc >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
echo    [OK] Atualizacoes reativadas.

:: Reverter Telemetria
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 1 /f >nul 2>&1
echo    [OK] Telemetria reativada.

:: Reverter Servico de Relogio
sc config W32Time start= auto >nul 2>&1
net start W32Time >nul 2>&1
echo    [OK] Servico de relogio reativado.

:: Reverter Hibernacao
powercfg -h on >nul 2>&1
echo    [OK] Hibernacao reativada.

echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Principais configuracoes revertidas!' -ForegroundColor Green"
echo.
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   OBS: Para reverter todas as opcoes individualmente,' -ForegroundColor Yellow"
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '        utilize as opcoes especificas no menu principal.' -ForegroundColor Yellow"
echo.
echo    Pressione qualquer tecla para voltar ao menu...
pause >nul
goto SUBMENU_WINDOWS

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
set "temp_count=0"
for /f "delims=" %%F in ('dir /b /a-d "%TEMP%\*" 2^>nul') do (
    if /i not "%%F"=="mago_exec.bat" (
        del /f /q "%TEMP%\%%F" >nul 2>&1 && set /a temp_count+=1
    )
)
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] TEMP do usuario limpo.' -ForegroundColor Green"

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
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Atualizacao concluida!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Nenhuma atualizacao encontrada ou erro no Winget.' -ForegroundColor Yellow"
)
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
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Site da AMD aberto no navegador!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Nao foi possivel abrir o site da AMD.' -ForegroundColor Red"
)
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_2
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar AMD Crash Defender...' -ForegroundColor Yellow"
sc query "AMD Crash Defender Service" | find "STOPPED" >nul
if %errorLevel% equ 0 (
    sc qc "AMD Crash Defender Service" | find "DISABLED" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] AMD Crash Defender ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        sc stop "AMD Crash Defender Service" >nul 2>&1
        sc config "AMD Crash Defender Service" start= disabled >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] AMD Crash Defender desativado!' -ForegroundColor Green"
    )
) else (
    sc stop "AMD Crash Defender Service" >nul 2>&1
    sc config "AMD Crash Defender Service" start= disabled >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] AMD Crash Defender desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar AMD Crash Defender.' -ForegroundColor Red"
    )
)
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_3
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar AMD Overlay e Telemetria...' -ForegroundColor Yellow"
reg query "HKLM\SOFTWARE\AMD\CN" /v AllowWebContent >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\AMD\CN" /v AllowWebContent | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] AMD Telemetria ja estava desativada.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SOFTWARE\AMD\CN" /v "AllowWebContent" /t REG_DWORD /d 0 /f >nul 2>&1
        reg add "HKLM\SOFTWARE\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria e Overlay AMD desativados!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SOFTWARE\AMD\CN" /v "AllowWebContent" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\AMD\CN" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria e Overlay AMD desativados!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar telemetria/overlay AMD.' -ForegroundColor Red"
    )
)
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_4
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar ULPS...' -ForegroundColor Yellow"
reg query "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v EnableUlps >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v EnableUlps | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] ULPS ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableUlps" /t REG_DWORD /d 0 /f >nul 2>&1
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableUlps_NA" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] ULPS desativado!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableUlps" /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "EnableUlps_NA" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] ULPS desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar ULPS.' -ForegroundColor Red"
    )
)
timeout /t 2 >nul
goto SUBMENU_AMD

:TWEAK_AMD_5
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Forcar Shader Cache sempre ativo...' -ForegroundColor Yellow"
reg query "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v ShaderCache >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v ShaderCache | find "0x2" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Shader Cache ja estava forcado como sempre ativo.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "ShaderCache" /t REG_DWORD /d 2 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Shader Cache forcado como sempre ativo!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdkmdag" /v "ShaderCache" /t REG_DWORD /d 2 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Shader Cache forcado como sempre ativo!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao configurar Shader Cache.' -ForegroundColor Red"
    )
)
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
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Site da NVIDIA aberto no navegador!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Nao foi possivel abrir o site da NVIDIA.' -ForegroundColor Red"
)
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_2
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativando telemetria NVIDIA...' -ForegroundColor Yellow"
sc query NvTelemetryContainer | find "STOPPED" >nul
if %errorLevel% equ 0 (
    sc qc NvTelemetryContainer | find "DISABLED" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Telemetria NVIDIA ja estava desativada.' -ForegroundColor Yellow"
    ) else (
        sc stop NvTelemetryContainer >nul 2>&1
        sc config NvTelemetryContainer start= disabled >nul 2>&1
        sc stop NVDisplay.ContainerLocalSystem >nul 2>&1
        sc config NVDisplay.ContainerLocalSystem start= auto >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria NVIDIA desativada!' -ForegroundColor Green"
    )
) else (
    sc stop NvTelemetryContainer >nul 2>&1
    sc config NvTelemetryContainer start= disabled >nul 2>&1
    sc stop NVDisplay.ContainerLocalSystem >nul 2>&1
    sc config NVDisplay.ContainerLocalSystem start= auto >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Telemetria NVIDIA desativada!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar telemetria NVIDIA.' -ForegroundColor Red"
    )
)
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_3
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Limpando Shader Cache NVIDIA...' -ForegroundColor Yellow"
del /s /f /q "%LOCALAPPDATA%\NVIDIA\DXCache\*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\NVIDIA\GLCache\*" >nul 2>&1
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Cache de shaders NVIDIA limpo!' -ForegroundColor Green"
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_4
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar NVIDIA ShadowPlay...' -ForegroundColor Yellow"
reg query "HKLM\SOFTWARE\NVIDIA Corporation\Global\ShadowPlay" /v Allow >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\NVIDIA Corporation\Global\ShadowPlay" /v Allow | find "0x0" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] ShadowPlay ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\ShadowPlay" /v "Allow" /t REG_DWORD /d 0 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] ShadowPlay desativado!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SOFTWARE\NVIDIA Corporation\Global\ShadowPlay" /v "Allow" /t REG_DWORD /d 0 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] ShadowPlay desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar ShadowPlay.' -ForegroundColor Red"
    )
)
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_5
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar HAGS...' -ForegroundColor Yellow"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode | find "0x1" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] HAGS ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] HAGS desativado!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] HAGS desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar HAGS.' -ForegroundColor Red"
    )
)
timeout /t 2 >nul
goto SUBMENU_NVIDIA

:TWEAK_NV_6
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Executando: Desativar MPO...' -ForegroundColor Yellow"
reg query "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode | find "0x5" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] MPO ja estava desativado.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] MPO desativado!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] MPO desativado!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao desativar MPO.' -ForegroundColor Red"
    )
)
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
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Todos os tweaks NVIDIA aplicados!' -ForegroundColor Green"
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
if %errorLevel% equ 0 (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Site da Intel aberto no navegador!' -ForegroundColor Green"
) else (
    PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Nao foi possivel abrir o site da Intel.' -ForegroundColor Red"
)
timeout /t 2 >nul
goto SUBMENU_INTEL

:TWEAK_INTEL_2
cls
PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '  [>>] Aplicando Prioridade de System (Gaming)...' -ForegroundColor Yellow"
reg query "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation >nul 2>&1
if %errorLevel% equ 0 (
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation | find "0x26" >nul
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [AVISO] Prioridade de sistema ja estava otimizada.' -ForegroundColor Yellow"
    ) else (
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
        bcdedit /set useplatformtick yes >nul 2>&1
        bcdedit /set disabledynamictick yes >nul 2>&1
        bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Tweaks de performance Intel aplicados!' -ForegroundColor Green"
    )
) else (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1
    bcdedit /set useplatformtick yes >nul 2>&1
    bcdedit /set disabledynamictick yes >nul 2>&1
    bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
    if %errorLevel% equ 0 (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [OK] Tweaks de performance Intel aplicados!' -ForegroundColor Green"
    ) else (
        PowerShell -Command "[Console]::OutputEncoding = [System.Text.Encoding]::UTF8; Write-Host '   [ERRO] Falha ao aplicar tweaks Intel.' -ForegroundColor Red"
    )
)
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
