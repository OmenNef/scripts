#!/bin/bash

# ������� ��� ��������� ������
handle_error() {
    echo -e "\e[31m������: $1\e[0m"  # ������� ����� ��� ������
    exit 1
}

# ��������, ���������� �� headscale
if ! command -v headscale &> /dev/null; then
    handle_error "Headscale �� ����������. ����������, ���������� ��� � ���������� �����."
fi

# �������� ������������ adminhq
echo -e "\e[34m�������� ������������ adminhq...\e[0m"  # ����� �����
headscale users create adminhq || handle_error "�� ������� ������� ������������ adminhq."

# ��������� ����� ����������� ��� ������������ adminhq ��� ����� --expiration
echo -e "\e[34m��������� ����� ����������� ��� ������������ adminhq...\e[0m"  # ����� �����
AUTH_KEY=$(headscale authkey --user adminhq) || handle_error "�� ������� ������������� ���� �����������."

# ����� ��������� ��� ����������� �������
echo -e "\e[32m���������� ������� � ������� ��������� �������:\e[0m"  # ������� �����
printf "tailscale up --authkey=%s\n" "$AUTH_KEY"  # ���������� printf ��� ����������� �����������
