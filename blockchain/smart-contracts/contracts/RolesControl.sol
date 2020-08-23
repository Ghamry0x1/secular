pragma solidity ^0.6.1;
pragma experimental ABIEncoderV2; 

//import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Roles.sol';

contract RolesControl{

    // using Roles for Roles.Role;
    // Roles.Role private admin;
    // Roles.Role private dataProviders;
    // Roles.Role private modelCreater;

    struct MetaData{
        string data;
    }
    function IsUserValid (string memory _CID,string memory _user,uint _startingRow,uint _endingRow,string memory _column) public view returns(bool){
        for(uint i =0;i < providers.length ;i++){
                if(keccak256(abi.encodePacked(providers[i].file.CID)) == keccak256(abi.encodePacked(_CID))){
                    uint x = providers[i].file.accessControl.users.length;
                    for(uint j = 0 ; j < x ; j++){
                        if(keccak256(abi.encodePacked(providers[i].file.accessControl.users[j])) == keccak256(abi.encodePacked(_user)) && (providers[i].file.accessControl.startingRow <= _startingRow && providers[i].file.accessControl.endingRow >= _endingRow)){
                            for(uint k = 0;k<providers[i].file.accessControl.columns.length;k++){
                                if(keccak256(abi.encodePacked(providers[i].file.accessControl.columns[k])) == keccak256(abi.encodePacked(_column))){
                                    return true;
                                }
                            }
                        }
                    }
                }
            
        }
        return false;
    }
    function addDataProvider(string memory _Address,string memory _CID,string memory _metaDataCID,string[] memory _users,uint _startingRow,uint _endingRow,string[] memory _columns) public {
        
        providers.push(dataProvider(_Address,File(_CID,_metaDataCID,AccessControl(_users,_startingRow,_endingRow,_columns))));
    }
    
    // function DoNothing (string[] memory all)public{
    //     require(false,all);
    // }
    dataProvider[] private providers;

    struct dataProvider{

    string addr;
    File file;
    }

    struct File{
        string CID;
        string metaDataCID;
        AccessControl accessControl;
    }
  
    struct AccessControl{
    
        string[] users;
        uint startingRow;
        uint endingRow;
        string[] columns;
    
    }
}
    // constructor() public {
    //     admin.add(msg.sender);
    // }

    // function addAdmin(address _newAdmin) external onlyAdmin() {
    //     admin.add(_newAdmin);
    // }

    // function removeAdmin(address _admin) external onlyAdmin() {
    //     admin.remove(_admin);
    // }

    // function addDataProvider(address _newDataProvider) external onlyAdmin() {
    //     dataProviders.add(_newDataProvider);
    // }

    // function removeDataProvider(address _dataProvider) external onlyAdmin() {
    //     dataProviders.remove(_dataProvider);
    // }

    // function addModelCreater(address _newModelCreater) external onlyAdmin() {
    //     modelCreater.add(_newModelCreater);
    // }

    // function removeModelCreater(address _modelCreater) external onlyAdmin() {
    //     modelCreater.remove(_modelCreater);
    // }

    // modifier onlyAdmin() {
    //     require(admin.has(msg.sender),'not an ADMIN');
    //     _;
    // }

    // modifier onlyDataProvider() {
    //     require(dataProviders.has(msg.sender),'not a Data Provider');
    //     _;
    // }

    // modifier onlyModelCreater() {
    //     require(modelCreater.has(msg.sender),'not a Model Creater');
    //     _;
    // }
//}
