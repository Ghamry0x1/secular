FROM ubuntu:18.04
RUN apt-get update -y
RUN apt-get install wget -y
RUN apt-get install tar -y

RUN wget https://dist.ipfs.io/ipfs-update/v1.5.2/ipfs-update_v1.5.2_linux-amd64.tar.gz
RUN tar -xvf ipfs-update_v1.5.2_linux-amd64.tar.gz
RUN ./ipfs-update/install.sh
RUN /usr/local/bin/ipfs-update/ipfs-update install latest
RUN ipfs init
RUN ipfs bootstrap rm --all
RUN ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
RUN ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
RUN export LIBP2P_FORCE_PNET=1
RUN ipfs daemon > ipfs.log &

EXPOSE 5001 8080