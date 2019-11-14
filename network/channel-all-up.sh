echo "###"
echo "### bring up channel-all"
echo "### and join three orgs to channel-all"
echo "###"
echo 
echo "# create block"
docker exec cli peer channel create -o orderer.example.com:7050  -c channel-all -f ./channel-artifacts/channel-all.tx

echo "# join peer0.org1 to channel-all"
docker exec cli peer channel join -b channel-all.block

echo "# join peer0.org2 to channel-all"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_PEER_LOCALMSPID="Org2MSP"  cli peer channel join -b channel-all.block

echo "# join peer0.org3 to channel-all"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp -e CORE_PEER_ADDRESS=peer0.org3.example.com:7051 -e CORE_PEER_LOCALMSPID="Org3MSP"  cli peer channel join -b channel-all.block

echo "# update anchor peer for peer0.org1"
docker exec cli peer channel update -o orderer.example.com:7050 -c channel-all -f ./channel-artifacts/Org1MSPanchors.tx

echo "# update anchor peer for peer0.org2"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_PEER_LOCALMSPID="Org2MSP"  cli peer channel update -o orderer.example.com:7050 -c channel-all -f ./channel-artifacts/Org2MSPanchors.tx

echo "# update anchor peer for peer0.org3"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp -e CORE_PEER_ADDRESS=peer0.org3.example.com:7051 -e CORE_PEER_LOCALMSPID="Org3MSP"  cli peer channel update -o orderer.example.com:7050 -c channel-all -f ./channel-artifacts/Org3MSPanchors.tx

echo "###"
echo "### channel-all created and joined by all orgs"
echo "###"