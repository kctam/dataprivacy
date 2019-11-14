package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	pb "github.com/hyperledger/fabric/protos/peer"
)

type Record struct {
	Id    string `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}

type PiiRecord struct {
	Id       string `json:"id"`
	Passport string `json:"passport"`
}

type SimpleChaincode struct {
}

func (t *SimpleChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response {
	return shim.Success(nil)
}

func (t *SimpleChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response {
	function, args := stub.GetFunctionAndParameters()
	switch function {
	case "createRecord":
		return t.createrecord(stub, args)
	case "queryRecord":
		return t.queryrecord(stub, args)
	case "queryPiiRecord":
		return t.querypiirecord(stub, args)
	default:
		return shim.Error("Invalid invoke function name")
	}
}

func (t *SimpleChaincode) createrecord(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	id := args[0]
	name := args[1]
	email := args[2]
	passport := args[3]

	record := &Record{id, name, email}
	recordAsBytes, _ := json.Marshal(record)

	stub.PutState(id, recordAsBytes)

	piiRecord := &PiiRecord{id, passport}
	piiRecordAsBytes, _ := json.Marshal(piiRecord)
	err := stub.PutPrivateData("collectionPrivate", id, piiRecordAsBytes)
	if err != nil {
		return shim.Error(err.Error())
	}
	return shim.Success(nil)
}

func (t *SimpleChaincode) queryrecord(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	id := args[0]
	recordAsBytes, _ := stub.GetState(id)
	return shim.Success(recordAsBytes)
}

func (t *SimpleChaincode) querypiirecord(stub shim.ChaincodeStubInterface, args []string) pb.Response {
	id := args[0]
	piiRecordAsBytes, err := stub.GetPrivateData("collectionPrivate", id)
	if err != nil {
		return shim.Error(err.Error())
	}
	return shim.Success(piiRecordAsBytes)
}

func main() {
	err := shim.Start(new(SimpleChaincode))
	if err != nil {
		fmt.Printf("Error starting Simple chaincode: %s", err)
	}
}
