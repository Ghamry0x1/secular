# Secular

A decentralized blockchain-based data privacy-preserving platform

# Introduction

Secular aims to provide a secure private platform where parties (i.e. OEMs) can upload their data, and on the other side, a program for data processing can be provided to process on pieces of data based on their RBAC; guaranteeing data integrity and privacy by using a private blockchain and IPFS networks. The data provider gives access to a certain user(s) via Smart Contracts; where only authorized users are process on this piece of data without compromising or exposing the data.

## Use Case: Machine Learning Model Training

1. Model creators can upload their models for training, as well as providing the required data by the data provider.

2. The data provider gives access to a certain user(s) via Smart Contracts; where only authorized users are allowed to train their models on this piece of data.

3. After the model is validated and whitelisted for network and I/O usage, the model node retrieves the data to start training; and self-destruct itself after the training phase is completed.

4. At the end, model creator has the model results to be downloaded and statistical charts presented on a dashboard. While the data provider has a dashboard showing which model is trained on his data and what are the model results.

![high-level-architecture](https://user-images.githubusercontent.com/25902120/91210695-e6bda200-e70d-11ea-8feb-35db0d8217d5.png)

# Getting Started

## Environment Setup

### Update apt package index

```
sudo apt-get update
```

### Install newer versions of packages

```
sudo apt-get upgrade -y
```

### Allow apt to use a repository over HTTPS

```
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
```

### Install NodeJS and npm

```
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
```

### Add Docker official GPG key

```
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

### Setup Docker stable repository

```
sudo add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
```

### Setup Go Repository

```
sudo add-apt-repository ppa:longsleep/golang-backports -y
```

### Update apt package index

```
sudo apt-get update
```

### Install Docker Engine

```
sudo apt-get -y install docker-ce
```

### Install Go

```
sudo apt-get install golang-go -y
```

### Download Docker Compose

```
sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
```

### Apply executable permissions to the binary

```
sudo chmod +x /usr/local/bin/docker-compose
```

## Install Truffle

```
sudo npm i -g truffle
```

## Install IPFS

### Get ipfs-update

```
sudo wget https://dist.ipfs.io/ipfs-update/v1.5.2/ipfs-update_v1.5.2_linux-amd64.tar.gz
```

### unzip ipfs-update

```
sudo tar -xvf ipfs-update_v1.5.2_linux-amd64.tar.gz
```

### install ipfs-update

```
sudo ./ipfs-update/install.sh
```

### install ipfs latest

```
sudo /usr/local/bin/ipfs-update/ipfs-update install latest
sudo nano /etc/systemd/system/ipfs.service
```

Add ipfs.service

```
[Unit]
Description=IPFS Daemon
After=syslog.target network.target remote-fs.target nss-lookup.target

[Service]
Type=simple
ExecStart=/usr/local/bin/ipfs daemon --enable-namesys-pubsub
User=root

[Install]
WantedBy=multi-user.target
```

Enable the service

```
sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl start ipfs
sudo systemctl status ipfs
```

# Build and Test

## IPFS

- ### Switch to root

  ```
  su
  ```

- ### Initialize IPFS Nodes

  ```
  ipfs init
  ```

- ### Check IPFS Node Config

  ```
  ipfs config show
  ```

- ### Remove Public Bootstrap Nodes

  ```
  ipfs bootstrap rm --all
  ```

- ### Change Gateway and API IPs

  ```
  ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
  ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
  ```

- ### Export LIBP2P

  ```
  export LIBP2P_FORCE_PNET=1
  ```

- ### Connect the Nodes with Each Other

  - #### Bring Nodes Online

    ```
    systemctl restart ipfs
    systemctl status ipfs
    ```

  - #### At Node 1

    ```
    ipfs id
    ```

  - #### At Node 2

    ```
    ipfs bootstrap add :id
    ```

  - #### Test the Connection

    ```
    ipfs swarm peers
    ```

- ### Upload File From Node 1

  ```
  echo "Distributed file on Private Network" > test.priv
  ipfs add test.priv
  ```

## Quorum Network

```
sudo QUORUM_CONSENSUS=raft docker-compose up -d
```

## Compile and Migrate Smart Contracts to Quorum Network

```
sudo truffle compile --reset
sudo truffle migrate --network development
```

## Invoke Smart Contract Functions

```
sudo truffle console --network development

RBAC.at('0x9d13C6D3aFE1721BEef56B55D303B09E021E27ab').then(function(instance) {return instance.addDataProvider('0xcE69AFd3b1738B2faF87F713473E75B11d5933B1', 'QmThk5n3hLfY1GWiAXcj9VFJ37h8Bsx4xXXbwrKxHQddtY', 'QmeomffUNfmQy76CQGy9NdmqEnnHU9soCexBnGU3ezPHVH', ['0xb6F8625ee20e6Ed6313393C733859eb006DF86dc'], 100, 3000, ['Title', 'Model', 'Estimated Price', 'Available Colors', 'Release Date']);})

RBAC.at('0x9d13C6D3aFE1721BEef56B55D303B09E021E27ab').then(function(instance) {return instance.isAuthorizedUser('QmThk5n3hLfY1GWiAXcj9VFJ37h8Bsx4xXXbwrKxHQddtY', '0xb6F8625ee20e6Ed6313393C733859eb006DF86dc', 1, 14, 'height');}) --> false

RBAC.at('0x9d13C6D3aFE1721BEef56B55D303B09E021E27ab').then(function(instance) {return instance.isAuthorizedUser('QmThk5n3hLfY1GWiAXcj9VFJ37h8Bsx4xXXbwrKxHQddtY', '0xb6F8625ee20e6Ed6313393C733859eb006DF86dc', 200, 300, 'height');}) --> false

RBAC.at('0x9d13C6D3aFE1721BEef56B55D303B09E021E27ab').then(function(instance) {return instance.isAuthorizedUser('QmThk5n3hLfY1GWiAXcj9VFJ37h8Bsx4xXXbwrKxHQddtY', '0xb6F8625ee20e6Ed6313393C733859eb006DF86dc', 200, 300, 'Title');}) -- > true
```
