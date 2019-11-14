# Demonstration for Channel and Private Data in Hyperledger Fabric

## Overview
This repository is the demonstration setup showing **Channel** and **Private Data** in Hyperledger Fabric. Refer to this article for detail.

## Note
For demo purpose both the **crypto-config** and **channel-artifacts** are pre-generated. The files are generated with **Release 1.4.2**.
In case you are using **Release 1.4.3**, you have to re-generate the channel-artifacts. After you git clone the repository, you can generate the new set of channel artifacts.
```
cd fabric-samples
git clone https://github.com/kctam/dataprivacy.git
cd dataprivacy/network

### in configtx.html line 79, change 
### from V1_4_2: true 
### to V1_4_3: true

rm channel-artifacts/*
export FABRIC_CFG_PATH=$PWD
../../bin/configtxgen -profile ThreeOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
../../bin/configtxgen -profile Channel-All -outputCreateChannelTx ./channel-artifacts/channel-all.tx -channelID channel-all
../../bin/configtxgen -profile Channel-12 -outputCreateChannelTx ./channel-artifacts/channel-12.tx -channelID channel-12
../../bin/configtxgen -profile Channel-All -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID channel-all -asOrg Org1MSP
../../bin/configtxgen -profile Channel-All -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID channel-all -asOrg Org2MSP
../../bin/configtxgen -profile Channel-All -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID channel-all -asOrg Org3MSP
```
