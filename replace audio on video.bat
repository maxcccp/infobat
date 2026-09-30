@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

rem Проходим по всем MP4-файлам в папке
FOR %%v in (*.mp4) do (
    echo Обрабатываю видео: %%v

    rem Извлекаем базовое имя файла без расширения
    set "FILENAME=%%~nv"
    set "AUDIO_FILE=!FILENAME!.mp3"

    rem Проверяем, существует ли соответствующий MP3-файл
    if exist "!AUDIO_FILE!" (
        set "OUTPUT_FILE=!FILENAME!_rus.mp4"
        echo Использую аудио: !AUDIO_FILE!
        echo Создаю: !OUTPUT_FILE!

        rem Запускаем ffmpeg: копируем видео, заменяем аудио
        ffmpeg -y -i "%%v" -i "!AUDIO_FILE!" ^
            -c:v copy ^
            -c:a aac -b:a 192k ^
            -map 0:v:0 ^
            -map 1:a:0 ^
            -shortest ^
            "!OUTPUT_FILE!"

        if errorlevel 1 (
            echo Ошибка при обработке %%v
        ) else (
            echo Успешно: !OUTPUT_FILE! создан
        )
    ) else (
        echo Предупреждение: MP3-файл !AUDIO_FILE! не найден для %%v
    )
)

echo Готово!
pause
