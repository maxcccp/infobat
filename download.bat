@echo off
:: 1. Устанавливаем кодировку UTF-8 для отображения русского языка UTF-8
chcp 65001 > nul

:: 1. Переходим в папку, где лежит сам bat-файл
pushd "%~dp0"

echo Начало скачивания v2rayN...

:: 2. Запуск скачивания через BITSADMIN (МЕДЛЕННАЯ!)
:: "v2ray_download" — это просто название задачи (можно написать любое)
:: В конце указан путь, куда сохранить файл (сохранится в папку со скриптом)
:: bitsadmin /transfer "v2ray_download" https://github.com/2dust/v2rayN/releases/download/7.25.3/v2rayN-windows-64-desktop.zip "%~dp0v2rayN-windows-64-desktop.zip"

:: Вызываем PowerShell и передаем ему команду на скачивание
:: powershell -Command "Start-BitsTransfer -Source 'https://github.com/2dust/v2rayN/releases/download/7.25.3/v2rayN-windows-64-desktop.zip' -Destination '%~dp0v2rayN-windows-64-desktop.zip'"

:: Параметр -L нужен для правильной обработки перенаправлений (редиректов) GitHub
curl -L "https://github.com/2dust/v2rayN/releases/download/7.25.3/v2rayN-windows-64-desktop.zip" -o "%~dp0v2rayN-windows-64-desktop.zip"

echo Скачивание завершено!
pause

:: 3. Возвращаем исходную директорию
popd
