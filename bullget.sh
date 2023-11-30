#!/bin/bash
echo "
█▀▀▀▄░░░█▀▀▀▀█░▀▀▀█▀▀▀▒█▀▀▀▀█▒▒█ █
█░░░░█░░█░░░▒█░░░░█░░▒▒█▒▒▒▒█▒▒█ █
█░░░░█░░█░░░▒█░░░░█░░▒▒█▄▄▄▄█▒▒█ █
█░░░░█░░█░░░▒█░░░░█░░▒▒█▒▒▒▒█▒▒█ █
█▄▄▄▀░░░█▄▄▄▄█░░░░█░░▒▒█▒▒▒▒█▒▒█ █
"

echo -e "\e[32mВася писька усата!\e[0m"
echo -e "\e[32mВася писька усата!\e[0m"
echo -e "\e[32mВася писька усата!\e[0m"
echo -e "\e[32mВася писька усата!\e[0m"
echo -e "\e[32mВася писька усата!\e[0m"
echo -e "\e[32mВася писька усата!\e[0m"
sudo apt-get install curl -y
echo -e "\e[32mВася писька усата!\e[0m"
sudo apt update
echo -e "\e[32mВася писька усата!\e[0m"
sudo apt install docker.io -y
echo -e "\e[32mВася писька усата!\e[0m"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
echo -e "\e[32mВася писька усата!\e[0m"
sudo chmod +x /usr/local/bin/docker-compose
curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
echo -e "\e[32mВася писька усата!\e[0m"

