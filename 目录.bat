@echo off
chcp 65001 > nul
echo === 基础测试 ===
echo 1. 当前目录: %cd%
echo 2. 正在生成 _sidebar.md...
docsify-auto-sidebar -d . -o _sidebar.md
if %errorlevel% neq 0 (
    echo ❌ 生成失败！请手动运行命令检查。
    pause
    exit /b
)
echo ✅ 生成成功！
pause