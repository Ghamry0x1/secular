pragma solidity ^0.5.1;
pragma experimental ABIEncoderV2;

contract RBAC {
    struct MetaData {
        string data;
    }

    struct dataProvider {
        string addr;
        File file;
    }

    struct File {
        string CID;
        string metaDataCID;
        AccessControl accessControl;
    }

    struct AccessControl {
        string[] users;
        uint256 startingRow;
        uint256 endingRow;
        string[] columns;
    }

    event dataProviderAdded(string);
    event fileAdded(string);

    dataProvider[] private providers;

    function isAuthorizedUser(
        string memory _CID,
        string memory _user,
        uint256 _startingRow,
        uint256 _endingRow,
        string memory _column
    ) public view returns (bool) {
        for (uint256 i = 0; i < providers.length; i++) {
            if (
                keccak256(abi.encodePacked(providers[i].file.CID)) ==
                keccak256(abi.encodePacked(_CID))
            ) {
                uint256 x = providers[i].file.accessControl.users.length;
                for (uint256 j = 0; j < x; j++) {
                    if (
                        keccak256(
                            abi.encodePacked(
                                providers[i].file.accessControl.users[j]
                            )
                        ) ==
                        keccak256(abi.encodePacked(_user)) &&
                        (providers[i].file.accessControl.startingRow <=
                            _startingRow &&
                            providers[i].file.accessControl.endingRow >=
                            _endingRow)
                    ) {
                        for (
                            uint256 k = 0;
                            k < providers[i].file.accessControl.columns.length;
                            k++
                        ) {
                            if (
                                keccak256(
                                    abi.encodePacked(
                                        providers[i]
                                            .file
                                            .accessControl
                                            .columns[k]
                                    )
                                ) == keccak256(abi.encodePacked(_column))
                            ) {
                                return true;
                            }
                        }
                    }
                }
            }
        }
        return false;
    }

    function addFile(
        string memory _CID,
        string memory _metaDataCID,
        string[] memory _users,
        uint256 _startingRow,
        uint256 _endingRow,
        string[] memory _columns
    ) public returns (File memory) {
        File memory f = File(
            _CID,
            _metaDataCID,
            AccessControl(_users, _startingRow, _endingRow, _columns)
        );
        emit fileAdded("- File is Added Successfully");
        return f;
    }

    function addDataProvider(
        string memory _Address,
        string memory _CID,
        string memory _metaDataCID,
        string[] memory _users,
        uint256 _startingRow,
        uint256 _endingRow,
        string[] memory _columns
    ) public {
        File memory _file = addFile(
            _CID,
            _metaDataCID,
            _users,
            _startingRow,
            _endingRow,
            _columns
        );
        providers.push(dataProvider(_Address, _file));
        emit dataProviderAdded("- Data Provider is Added Successfully");
    }
}
