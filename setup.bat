@echo off
chcp 65001 >nul
title إعداد تحليل أداء السائقين - الرؤية الحديثة LG
color 0A

echo.
echo ══════════════════════════════════════════════════════
echo   تحليل أداء السائقين - الرؤية الحديثة LG
echo   إعداد تلقائي للبرنامج
echo ══════════════════════════════════════════════════════
echo.

:: ── Check Rust ──
echo [1/4] فحص Rust...
rustc --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   !! Rust غير مثبّت على هذا الجهاز
    echo.
    echo   سيتم فتح صفحة التثبيت في المتصفح...
    echo   اتبع الخطوات ثم أعِد تشغيل هذا الملف.
    echo.
    start https://rustup.rs
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('rustc --version') do echo   OK: %%i
)

:: ── Check Node.js ──
echo.
echo [2/4] فحص Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo   !! Node.js غير مثبّت على هذا الجهاز
    echo.
    echo   سيتم فتح صفحة التثبيت في المتصفح...
    echo   اختر النسخة LTS ثم أعِد تشغيل هذا الملف.
    echo.
    start https://nodejs.org
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version') do echo   OK: Node.js %%i
)

:: ── Install npm dependencies ──
echo.
echo [3/4] تثبيت مكتبات Tauri...
call npm install
if %errorlevel% neq 0 (
    echo   !! فشل تثبيت المكتبات
    pause
    exit /b 1
)
echo   OK: تم تثبيت المكتبات

:: ── Build the app ──
echo.
echo [4/4] بناء البرنامج (قد يستغرق 3-5 دقائق في أول مرة)...
echo   جاري تحميل مكتبات Rust وبناء البرنامج...
echo.
call npm run build

if %errorlevel% neq 0 (
    echo.
    echo   !! فشل البناء - راجع الأخطاء أعلاه
    echo   تلميح: تأكد من تثبيت Microsoft C++ Build Tools
    echo   رابط: https://aka.ms/vs/17/release/vs_BuildTools.exe
    pause
    exit /b 1
)

echo.
echo ══════════════════════════════════════════════════════
echo   تم البناء بنجاح!
echo.
echo   ملف التثبيت في:
echo   src-tauri\target\release\bundle\msi\
echo   أو
echo   src-tauri\target\release\bundle\nsis\
echo ══════════════════════════════════════════════════════
echo.
pause
