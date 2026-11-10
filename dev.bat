@echo off
chcp 65001 >nul
title تحليل أداء السائقين - وضع التطوير
echo.
echo   تشغيل البرنامج في وضع التطوير...
echo   (للتطوير فقط - استخدم setup.bat لبناء النسخة النهائية)
echo.
npm run dev
pause
