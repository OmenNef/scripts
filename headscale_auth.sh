#!/bin/bash

# Функция для обработки ошибок
handle_error() {
    echo "Ошибка: $1"
    exit 1
}

# Проверка, установлен ли headscale
if ! command -v headscale &> /dev/null; then
    handle_error "Headscale не установлен. Пожалуйста, установите его и попробуйте снова."
fi

# Создание пользователя adminhq
echo "Создание пользователя adminhq..."
headscale users create adminhq || handle_error "Не удалось создать пользователя adminhq."

# Генерация ключа авторизации для пользователя adminhq без флага --expiration
echo "Генерация ключа авторизации для пользователя adminhq..."
AUTH_KEY=$(headscale authkey --user adminhq) || handle_error "Не удалось сгенерировать ключ авторизации."

# Вывод сообщения для подключения клиента
echo -e "\e[32mПодключите клиента с помощью следующей команды:\e[0m"
echo "tailscale up --authkey=$AUTH_KEY"
