pragma solidity ^0.5.8;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Roles.sol';

contract RolesControl{

    using Roles for Roles.Role;
    Roles.Role private admin;
    Roles.Role private dataProviders;
    Roles.Role private modelCreater;

    struct MetaData{

    }
    
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

