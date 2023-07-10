#!/bin/bash

# Aktualizacja systemu
sudo apt update && sudo apt upgrade

# Instalowanie pakietów
sudo apt-get install gstreamer1.0-tools gstreamer1.0-alsa \
     gstreamer1.0-plugins-base gstreamer1.0-plugins-good \
     gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
     gstreamer1.0-libav \
     libgstreamer1.0-dev \
     libgstreamer-plugins-base1.0-dev \
     libgstreamer-plugins-good1.0-dev \
     libgstreamer-plugins-bad1.0-dev \
     doxygen asciidoc curl cabextract wireshark

# Utworzenie katalogu i przejście do niego
mkdir Repo
cd Repo

# Klonowanie i budowanie libcoap
git clone https://github.com/obgm/libcoap.git
cd libcoap
./autogen.sh
./configure --disable-dtls
make
sudo make install

# Aktualizacja LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib

cd ..

# Klonowanie i budowanie xow
git clone https://github.com/medusalix/xow.git
cd xow
sudo make BUILD=RELEASE
sudo make install
sudo ./xow-get-firmware.sh --skip-disclaimer
sudo systemctl enable xow
sudo systemctl start xow
sudo systemctl stop xow
sudo systemctl start xow

cd ..

# Klonowanie i budowanie wiringJet
git clone https://github.com/wiringGpio/wiringJet.git
cd wiringJet
sudo make
sudo make install
