@echo off
git add .
git commit -m "Add new files for sync"
git push origin main    # 同步到 Gitee
git push github main    # 同步到 GitHub
pause