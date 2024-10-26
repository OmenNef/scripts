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

# �������� ����� ������������ ��� ��������������
sudo vim /etc/headscale/config.sdyaml