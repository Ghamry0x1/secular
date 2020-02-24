#!/bin/bash

echo " "
echo "#################################"
echo "####### IPFS INIT STARTED #######"
echo "#################################"
echo " "

echo " "
echo "################################"
echo "####### Wget ipfs-update #######"
echo "################################"
echo " "
sudo wget https://dist.ipfs.io/ipfs-update/v1.5.2/ipfs-update_v1.5.2_linux-amd64.tar.gz

echo " "
echo "#################################"
echo "####### unzip ipfs-update #######"
echo "#################################"
echo " "
sudo tar -xvf ipfs-update_v1.5.2_linux-amd64.tar.gz

echo " "
echo "###################################"
echo "####### install ipfs-update #######"
echo "###################################"
echo " "
sudo ./ipfs-update/install.sh

echo " "
echo "###################################"
echo "####### install ipfs latest #######"
echo "###################################"
echo " "
sudo /usr/local/bin/ipfs-update/ipfs-update install latest

echo " "
echo "#########################"
echo "####### IPFS init #######"
echo "#########################"
echo " "
sudo ipfs init

echo " "
echo "#############################################"
echo "####### Remove public bootstrap nodes #######"
echo "#############################################"
echo " "
sudo ipfs bootstrap rm --all

echo " "
echo "##########################################"
echo "####### Change Gateway and API IPs #######"
echo "##########################################"
echo " "
sudo ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
sudo ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001

echo " "
echo "#############################"
echo "####### Export LIBP2P #######"
echo "#############################"
echo " "
export LIBP2P_FORCE_PNET=1

echo " "
echo "#################################"
echo "####### Move ipfs.service #######"
echo "#################################"
echo " "
sudo cp ipfs.service /etc/systemd/system

echo " "
echo "#####################################"
echo "####### Finalize ipfs.service #######"
echo "#####################################"
echo " "
sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl start ipfs
sudo systemctl status ipfs

echo " "
echo "########################"
echo "####### ALL GOOD #######"
echo "########################"
echo " "
