// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./SupNFT.sol";

contract UserManager {
    // check if user is already registered
    mapping(address => uint256) userId;
    uint256 users = 1;
    SupNFT public nftContract;
    constructor(address _nftContractAddress) {
        nftContract = SupNFT(_nftContractAddress);
    }
    
    modifier userExists(address userAddr) {
        require(userId[userAddr] != 0, "User is not registered");
        _;
    }

    function registerUser() public {
        require(userId[msg.sender] != 0, "User Already registered");
        userId[msg.sender] = users;
        users++;
         // Mint a new NFT for the user
        string memory tokenURI = string(abi.encodePacked("https://example.com/metadata/", toString(users - 1)));
        nftContract.mint(msg.sender, tokenURI);
    }
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
