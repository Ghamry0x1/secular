#!/bin/bash

echo -e "2901\n2901" | sudo passwd

echo " "
echo "####################################"
echo "####### SERVER SETUP STARTED #######"
echo "####################################"
echo " "

echo " "
echo "########################################"
echo "####### Update apt package index #######"
echo "########################################"
echo " "
sudo apt-get update

echo " "
echo "##################################################"
echo "####### Install newer versions of packages #######"
echo "##################################################"
echo " "
sudo apt-get upgrade -y

echo " "
echo "########################################################"
echo "####### Allow apt to use a repository over HTTPS #######"
echo "########################################################"
echo " "
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

echo " "
echo "##############################"
echo "####### Install NodeJS #######"
echo "##############################"
echo " "
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

echo " "
echo "###########################################"
echo "####### Add Docker official GPG key #######"
echo "###########################################"
echo " "
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo " "
echo "##############################################"
echo "####### Setup Docker stable repository #######"
echo "##############################################"
echo " "
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

echo " "
echo "###################################"
echo "####### Setup Go Repository #######"
echo "###################################"
echo " "
sudo add-apt-repository ppa:longsleep/golang-backports -y

echo " "
echo "########################################"
echo "####### Update apt package index #######"
echo "########################################"
echo " "
sudo apt-get update

echo " "
echo "#####################################"
echo "####### Install Docker Engine #######"
echo "#####################################"
echo " "
sudo apt-get -y install docker-ce

echo " "
echo "##########################"
echo "####### Install Go #######"
echo "##########################"
echo " "
sudo apt-get install golang-go -y

echo " "
echo "#######################################"
echo "####### Download Docker Compose #######"
echo "#######################################"
echo " "
sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

echo " "
echo "##########################################################"
echo "####### Apply executable permissions to the binary #######"
echo "##########################################################"
echo " "
sudo chmod +x /usr/local/bin/docker-compose

echo " "
echo "###############################"
echo "####### Install Truffle #######"
echo "###############################"
echo " "
sudo npm i -g truffle

echo " "
echo "###############################"
echo "####### Install Nodemon #######"
echo "###############################"
echo " "
sudo npm i -g nodemon

echo " "
echo "###########################"
echo "####### Install PM2 #######"
echo "###########################"
echo " "
sudo npm i -g pm2

echo " "
echo "########################"
echo "####### ALL GOOD #######"
echo "########################"
echo " "
