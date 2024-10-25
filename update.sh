#!/bin/bash

# Обновляем пакеты
echo "Обновление системы..."
sudo apt update && sudo apt upgrade -y

# Проверяем, требуется ли перезагрузка сервисов
echo "Проверка на необходимость перезагрузки сервисов..."

# Используем expect для автоматического ввода
expect -c '
    set timeout -1
    spawn sudo apt upgrade -y
    expect {
        "Which services should be restarted?" {
            send "1 2 3 4 5 6 7\r"
        }
        eof
    }
'

# Перезагрузка системы
echo "Перезагрузка системы..."
sudo reboot