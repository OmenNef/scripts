#!/bin/bash

# Функция для обработки ошибок
handle_error() {
    echo -e "\e[31mОшибка: $1\e[0m"  # Красный текст для ошибок
    exit 1
}

# Проверка, установлен ли headscale
if ! command -v headscale &> /dev/null; then
    handle_error "Headscale не установлен. Пожалуйста, установите его и попробуйте снова."
fi

# Создание пользователя adminhq
echo -e "\e[34mСоздание пользователя adminhq...\e[0m"  # Синий текст
headscale users create adminhq || handle_error "Не удалось создать пользователя adminhq."

# Генерация ключа авторизации для пользователя adminhq без флага --expiration
echo -e "\e[34mГенерация ключа авторизации для пользователя adminhq...\e[0m"  # Синий текст
AUTH_KEY=$(headscale authkey --user adminhq) || handle_error "Не удалось сгенерировать ключ авторизации."

# Вывод сообщения для подключения клиента
echo -e "\e[32mПодключите клиента с помощью следующей команды:\e[0m"  # Зеленый текст
printf "tailscale up --authkey=%s\n" "$AUTH_KEY"  # Используем printf для корректного отображения
