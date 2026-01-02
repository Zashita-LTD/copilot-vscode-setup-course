@echo off
REM VS Code + Copilot Auto Setup Script for Windows
REM Автоматическая настройка всего нужного для начала

echo.
echo  ========================================
echo  VS Code + Copilot Setup
echo  ========================================
echo.

REM Check if VS Code is installed
echo [1/5] Проверяю VS Code...
where code >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo  ❌ VS Code не установлен. Посетите https://code.visualstudio.com/
    exit /b 1
)
echo  ✅ VS Code обнаружен

REM Install extensions
echo.
echo [2/5] Устанавливаю расширения...
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension esbenp.prettier-vscode --force
code --install-extension eamodio.gitlens --force
code --install-extension humao.rest-client --force
code --install-extension ms-azuretools.vscode-docker --force
echo  ✅ Расширения установлены

REM Copy config files
echo.
echo [3/5] Копирую конфигурацию...
if exist "config" (
    if exist "config\.eslintrc.json" copy "config\.eslintrc.json" ".eslintrc.json" >nul 2>&1
    if exist "config\.prettierrc" copy "config\.prettierrc" ".prettierrc" >nul 2>&1
    echo  ✅ Конфигурация скопирована
)

REM Check npm
echo.
echo [4/5] Проверяю npm...
where npm >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo  ✅ npm исполняем...
    echo.
    echo [5/5] Устанавливаю dev-зависимости...
    call npm install --save-dev eslint prettier husky lint-staged >nul 2>&1
    call npx husky install >nul 2>&1
    echo  ✅ Зависимости установлены
) else (
    echo  ⚠️ npm не обнаружен. Пропускаю npm встановку
)

echo.
echo  ========================================
echo  ✨ Настройка завершена!
  echo  🚀 Ты можеш начинать писать код с Copilot!
  echo  ========================================
echo.
pause
