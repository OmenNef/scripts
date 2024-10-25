#!/bin/bash

# ������������� expect
echo "��������� expect..."
sudo apt update
sudo apt install expect -y

# ���������, ��������� �� ������������ ��������
echo "���������� ������� � �������� �� ������������� ������������ ��������..."

# ���������� expect ��� ��������������� �����
expect -c '
    set timeout -1
    spawn sudo apt update && sudo apt upgrade -y
    expect {
        "Which services should be restarted?" {
            send "1 2 3 4 5 6 7\r"
        }
        eof
    }
'

# ������������ �������
echo "������������ �������..."
sudo reboot