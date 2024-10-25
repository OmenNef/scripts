#!/bin/bash

# Устанавливаем expect
echo "Установка expect..."
sudo apt update
sudo apt install expect -y

# Проверяем, требуется ли перезагрузка сервисов
echo "Обновление системы и проверка на необходимость перезагрузки сервисов..."

# Используем expect для автоматического ввода
expect -c '
    set timeout -1

    # Запускаем команду apt update
    spawn sudo apt update
    expect eof

    # Запускаем команду apt upgrade и ожидаем возможный запрос на перезагрузку сервисов
    spawn sudo apt upgrade -y
    expect {
        "Which services should be restarted?" {
            send "1 2 3 4 5 6 7\r"
            exp_continue
        }
        eof
    }
'

# Перезагрузка системы
echo "Перезагрузка системы..."
sudo reboot