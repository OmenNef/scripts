#!/bin/bash
cd /
sudo apt-get install vim dialog -y
wget --output-document=/tmp/headscale.deb \
https://github.com/juanfont/headscale/releases/download/v0.23.0/headscale_0.23.0_linux_amd64.deb
sudo apt install /tmp/headscale.deb
sudo vim /etc/headscale/config.sdyaml