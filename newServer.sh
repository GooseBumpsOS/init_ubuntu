#!/bin/bash
sudo apt update -y
sudo apt upgrade -y

sudo apt install curl -y
sudo apt install mc -y
sudo apt install vim -y
sudo apt install wget -y
sudo apt install git -y
sudo apt install htop -y
sudo apt install net-tools -y

sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

cd ~
