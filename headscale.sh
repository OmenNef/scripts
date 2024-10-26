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

# Получаем текущий внешний IP адрес
EXTERNAL_IP=$(curl -s http://ipinfo.io/ip)

# Проверяем, что IP-адрес получен успешно
if [ -z "$EXTERNAL_IP" ]; then
    echo "Не удалось получить внешний IP адрес."
    exit 1
fi

# Путь к файлу конфигурации
CONFIG_FILE="/etc/headscale/config.yaml"

# Используем sed для замены значений
sudo sed -i "s|^server_url: http://.*|server_url: http://$EXTERNAL_IP:8080|" "$CONFIG_FILE"
sudo sed -i "s|^listen_addr: 127.0.0.1:8080|listen_addr: 0.0.0.0:8080|" "$CONFIG_FILE"

echo "Конфигурация обновлена:"
echo "server_url: http://$EXTERNAL_IP:8080"
echo "listen_addr: 0.0.0.0:8080"

# Enable and start the headscale service:
sudo systemctl enable --now headscale

# Verify that headscale is running as intended:
sudo systemctl status headscale
