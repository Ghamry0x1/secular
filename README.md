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

<br>

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

### install ipfs-update

```
install ipfs latest
```

# Build and Test

## Run Quorum Network

```
QUORUM_CONSENSUS=raft docker-compose up -d
```

## Migrate Smart Contracts to Quorum Network

```
sudo truffle migrate --network development
```

## IPFS

- ### Switch to root

  ```
  su
  ```

- ### Initialize IPFS Nodes

  ```
  ipfs init
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
    ipfs daemon > ipfs.log &
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
  echo "File from node 1, distributed on IPFS" > testFile.txt
  ```
