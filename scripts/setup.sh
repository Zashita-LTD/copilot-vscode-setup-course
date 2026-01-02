#!/bin/bash

# VS Code + Copilot Auto Setup Script
# Автоматическая настройка всего нужного для начала

echo "🚀 Начинаю автоматизированную настройку..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if VS Code is installed
echo -e "${YELLOW}[1/5]${NC} Проверяю VS Code..."
if command -v code &> /dev/null; then
    echo -e "${GREEN}✅ VS Code обнаружен${NC}"
else
    echo -e "${RED}❌ VS Code не установлен. Посетите https://code.visualstudio.com/${NC}"
    exit 1
fi

# Install extensions
echo -e "${YELLOW}[2/5]${NC} Устанавливаю расширения..."
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension esbenp.prettier-vscode --force
code --install-extension eamodio.gitlens --force
code --install-extension humao.rest-client --force
code --install-extension ms-azuretools.vscode-docker --force
echo -e "${GREEN}✅ Расширения установлены${NC}"

# Copy config files
echo -e "${YELLOW}[3/5]${NC} Копирую конфигурацию..."
if [ -d "config" ]; then
    cp config/.eslintrc.json .eslintrc.json 2>/dev/null
    cp config/.prettierrc .prettierrc 2>/dev/null
    echo -e "${GREEN}✅ Конфигурация скопирована${NC}"
fi

# Check npm
echo -e "${YELLOW}[4/5]${NC} Проверяю npm..."
if command -v npm &> /dev/null; then
    echo -e "${GREEN}✅ npm ноставлен${NC}"
    
    # Install dev dependencies
    echo -e "${YELLOW}[5/5]${NC} Устанавливаю dev-зависимости..."
    npm install --save-dev eslint prettier husky lint-staged 2>/dev/null
    npx husky install 2>/dev/null
    echo -e "${GREEN}✅ Зависимости установлены${NC}"
else
    echo -e "${YELLOW}⚠️ npm не обнаружен. Пропускаю npm встановку${NC}"
fi

echo ""
echo -e "${GREEN}✨ Настройка завершена!${NC}"
echo -e "${GREEN}🚀 Ты можеш начинать писать код с Copilot!${NC}"
echo ""
