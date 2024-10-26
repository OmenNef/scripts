#!/bin/bash

# Переключение в корневой каталог
cd /

# Установка необходимых пакетов
sudo apt-get install vim dialog -y

# Скачивание файла .deb в /tmp
wget --output-document=/tmp/headscale.deb \
https://github.com/juanfont/headscale/releases/download/v0.23.0/headscale_0.23.0_linux_amd64.deb

# Проверка успешности загрузки
if [ $? -ne 0 ]; then
    echo "Ошибка: не удалось загрузить headscale.deb"
    exit 1
fi

# Установка пакета
sudo apt install -y /tmp/headscale.deb

# Проверка успешности установки
if [ $? -ne 0 ]; then
    echo "Ошибка: не удалось установить headscale"
    exit 1
fi

# Открытие файла конфигурации для редактирования
sudo vim /etc/headscale/config.sdyaml