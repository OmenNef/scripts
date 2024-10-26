#!/bin/bash

# �������� ������� ������� IP �����
EXTERNAL_IP=$(curl -s http://ipinfo.io/ip)

# ���������, ��� IP-����� ������� �������
if [ -z "$EXTERNAL_IP" ]; then
    echo "�� ������� �������� ������� IP �����."
    exit 1
fi

# ���� � ����� ������������
CONFIG_FILE="/etc/headscale/config.yaml"

# ���������� sed ��� ������ ��������
sudo sed -i "s|^server_url: http://.*|server_url: http://$EXTERNAL_IP:8080|" "$CONFIG_FILE"
sudo sed -i "s|^listen_addr: 127.0.0.1:8080|listen_addr: 0.0.0.0:8080|" "$CONFIG_FILE"

echo "������������ ���������:"
echo "server_url: http://$EXTERNAL_IP:8080"
echo "listen_addr: 0.0.0.0:8080"