@echo off
echo -------------------------------
echo  📂 正在自动生成 _sidebar.md...
echo -------------------------------

:: 使用 Node.js 的 docsify-auto-sidebar 工具生成目录
docsify-auto-sidebar -d . -o _sidebar.md

echo -------------------------------
echo  📤 正在添加文件到 Git...
echo -------------------------------
git add .

:: 输入提交信息
set /p message="Enter commit message: "

echo -------------------------------
echo  ✅ 正在提交: %message%
echo -------------------------------
git commit -m "%message%"

echo -------------------------------
echo  🚀 推送到 Gitee...
echo -------------------------------
git push origin main

echo -------------------------------
echo  🚀 推送到 GitHub...
echo -------------------------------
git push github main

echo -------------------------------
echo  🌐 同步完成！Netlify/Pages 正在自动更新...
echo -------------------------------
pause
