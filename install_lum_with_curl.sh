#!/bin/bash
echo "Cloning repository"
git clone https://github.com/Desvelao/lum.git
echo "Installing lum"
cd lum && chmod 777 ./install.sh && sudo ./install.sh
echo "Removing lum folder"
cd .. && rm -rf lum
rm install_lum.sh