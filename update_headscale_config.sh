#!/bin/bash

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