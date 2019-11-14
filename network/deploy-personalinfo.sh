echo "###"
echo "### install and instantiate chaincode personalinfo to all peers and on channel-all"
echo "###"

echo "# install personalinfo on peer0.org1"
docker exec cli peer chaincode install -n mycc -v 0 -p github.com/chaincode/personalinfo

echo "# install personalinfo on peer0.org2"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp -e CORE_PEER_ADDRESS=peer0.org2.example.com:7051 -e CORE_PEER_LOCALMSPID="Org2MSP"  cli peer chaincode install -n mycc -v 0 -p github.com/chaincode/personalinfo

echo "# install personalinfo on peer0.org3"
docker exec -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3.example.com/users/Admin@org3.example.com/msp -e CORE_PEER_ADDRESS=peer0.org3.example.com:7051 -e CORE_PEER_LOCALMSPID="Org3MSP"  cli peer chaincode install -n mycc -v 0 -p github.com/chaincode/personalinfo

echo "# instantiate personalinfo on channel-all"
docker exec cli peer chaincode instantiate -o orderer.example.com:7050 -C channel-all -n mycc -v 0 -c '{"Args":[]}' -P "OR('Org1MSP.member','Org2MSP.member','Org3MSP.member')" --collections-config /opt/gopath/src/github.com/chaincode/personalinfo/collections_config.json

echo "###"
echo "### chaincode personalinfo deployment completes"
echo "###"