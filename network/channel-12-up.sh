echo "###"
echo "### bring up channel-12"
echo "### and join org1 and org2 to channel-12"
echo "###"
echo 
echo "# create block"
docker exec cli peer channel create -o orderer.example.com:7050  -c channel-12 -f ./channel-artifacts/channel-12.tx

echo "# join peer0.org1 to channel-12"
docker exec cli peer channel join -b channel-12.block

echo "# join peer0.org2 to channel-12"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_PEER_LOCALMSPID="Org2MSP"  cli peer channel join -b channel-12.block

echo "###"
echo "### channel-12 created and joined by org1 and org2"
echo "###"