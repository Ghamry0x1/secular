pragma solidity ^0.6.1;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Roles.sol';

contract RolesControl{

    using Roles for Roles.Role;
    Roles.Role private admin;
    Roles.Role private dataProviders;
    Roles.Role private modelCreater;

    struct MetaData{
        string data;
    }
    function IsUserValid(string _Address,string _CID,string _metaDataCID,string _user,uint _startingRow,uint _endingRow,string _column) external {
        for(uint i =0;i < providers.length ;i++){
            if(providers[i].file.CID == _CID)
                for(uint j = 0 ; j < providers[i].users.length ; j++){
                    if(providers[i].users[j] == _user && providers[i].startingRow >= _startingRow && providers[i].endingRow <= _endingRow)
                        for(uint k = 0;k<providers[i].columns.length;k++)
                            if(providers[i].columns[k] == _column)
                            return true;
                }
        }
        return false;
    }
    function addDataProvider(
      string _Address,string _CID,string _metaDataCID,string[] _users,uint _startingRow,uint _endingRow,string[] _columns) external {
        providers.push(dataProvider(_Address,File(_CID,_metaDataCID,AccessControl(_users,_startingRow,_endingRow,_columns))));
    }
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
    constructor() public {
        admin.add(msg.sender);
    }

    function addAdmin(address _newAdmin) external onlyAdmin() {
        admin.add(_newAdmin);
    }

    function removeAdmin(address _admin) external onlyAdmin() {
        admin.remove(_admin);
    }

    function addDataProvider(address _newDataProvider) external onlyAdmin() {
        dataProviders.add(_newDataProvider);
    }

    function removeDataProvider(address _dataProvider) external onlyAdmin() {
        dataProviders.remove(_dataProvider);
    }

    function addModelCreater(address _newModelCreater) external onlyAdmin() {
        modelCreater.add(_newModelCreater);
    }

    function removeModelCreater(address _modelCreater) external onlyAdmin() {
        modelCreater.remove(_modelCreater);
    }

    modifier onlyAdmin() {
        require(admin.has(msg.sender),'not an ADMIN');
        _;
    }

    modifier onlyDataProvider() {
        require(dataProviders.has(msg.sender),'not a Data Provider');
        _;
    }

    modifier onlyModelCreater() {
        require(modelCreater.has(msg.sender),'not a Model Creater');
        _;
    }
}
