#!/bin/bash

# ������������ � �������� �������
cd /

# ��������� ����������� �������
sudo apt-get install vim dialog -y

# ���������� ����� .deb � /tmp
wget --output-document=/tmp/headscale.deb \
https://github.com/juanfont/headscale/releases/download/v0.23.0/headscale_0.23.0_linux_amd64.deb

# �������� ���������� ��������
if [ $? -ne 0 ]; then
    echo "������: �� ������� ��������� headscale.deb"
    exit 1
fi

# ��������� ������
sudo apt install -y /tmp/headscale.deb

# �������� ���������� ���������
if [ $? -ne 0 ]; then
    echo "������: �� ������� ���������� headscale"
    exit 1
fi

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

# Enable and start the headscale service:
sudo systemctl enable --now headscale

# Verify that headscale is running as intended:
sudo systemctl status headscale
