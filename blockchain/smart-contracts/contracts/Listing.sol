pragma solidity ^0.5.8;
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Roles.sol';

contract Listing{
    
    using Roles for Roles.Role;
    Roles.Role private admin;
    Roles.Role private whiteList;

    constructor() public {
        admin.add(msg.sender);
    }

    function addAdmin(address _newAdmin) external onlyAdmin() {
        admin.add(_newAdmin);
    }

    function removeAdmin(address _admin) external onlyAdmin() {
        admin.remove(_admin);
    }

    function addToWhiteList(address _newWhiteList) external onlyAdmin() {
        whiteList.add(_newWhiteList);
    }

    function removeFromWhiteList(address _whiteList) external onlyAdmin() {
        whiteList.remove(_whiteList);
    }

    modifier onlyAdmin() {
        require(admin.has(msg.sender),'not an ADMIN');
        _;
    }
}