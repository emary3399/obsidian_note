@echo off
echo Adding files...
git add .
set /p message="Enter commit message: "
echo Committing changes...
git commit -m "%message%"
echo Pushing to Gitee...
git push origin main
echo Pushing to GitHub...
git push github main
echo Sync upload completed!
pause