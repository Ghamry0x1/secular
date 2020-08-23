pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2; 

contract RolesControl{


    struct MetaData{
        string data;
    }
    event dataProviderAdded(string);
    event fileAdd(string);
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
    function addFile(string memory _CID,string memory _metaDataCID,string[] memory _users,uint _startingRow,uint _endingRow,string[] memory _columns) public returns(File memory){
        File memory f = File(_CID,_metaDataCID,AccessControl(_users,_startingRow,_endingRow,_columns));
        emit dataProviderAdded("Created file successfully");
        return f;
    }
    function addDataProvider(string memory _Address,string memory _CID,string memory _metaDataCID,string[] memory _users,uint _startingRow,uint _endingRow,string[] memory _columns) public {
        File memory _file = addFile(_CID,_metaDataCID,_users,_startingRow,_endingRow,_columns);
        providers.push(dataProvider(_Address,_file));
        emit dataProviderAdded("Added new data provider successfully");
    }
    // function test() public returns(string memory){
    //     emit dataProviderAdded("hello there");
    //     return "S7so S7soo7";
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