#!/bin/bash

# ������� ��� ��������� ������
handle_error() {
    echo "������: $1"
    exit 1
}

# ��������, ���������� �� headscale
if ! command -v headscale &> /dev/null; then
    handle_error "Headscale �� ����������. ����������, ���������� ��� � ���������� �����."
fi

# �������� ������������ adminhq
echo "�������� ������������ adminhq..."
headscale users create adminhq || handle_error "�� ������� ������� ������������ adminhq."

# ��������� ����� ����������� ��� ������������ adminhq ��� ����� --expiration
echo "��������� ����� ����������� ��� ������������ adminhq..."
AUTH_KEY=$(headscale authkey --user adminhq) || handle_error "�� ������� ������������� ���� �����������."

# ����� ��������� ��� ����������� �������
echo -e "\e[32m���������� ������� � ������� ��������� �������:\e[0m"
echo "tailscale up --authkey=$AUTH_KEY"
