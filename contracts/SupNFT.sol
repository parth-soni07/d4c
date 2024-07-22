// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SupNFT is ERC721Enumerable, Ownable {
    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => address) private _tokenOwners;

    uint256 _tokenId;

    constructor(string memory name, string memory symbol) ERC721("SupNFT", "SUP") Ownable(msg.sender){
        _tokenId = 0;
    }

    function totalSupply() public view override(ERC721Enumerable) returns (uint256) {
        return _tokenId;
    }

    function mint(address to, string memory uri) public returns (uint256) {
        _tokenId++;
        uint256 newTokenId = _tokenId;
        _safeMint(to, newTokenId);
        _setTokenURI(newTokenId, uri);
        _tokenOwners[newTokenId] = to;
        return newTokenId;
    }

    function transferNFT(address from, address to, uint256 tokenId) public {
        // require(
        //     _isApprovedOrOwner(_msgSender(), tokenId),
        //     "Transfer caller is not owner nor approved"
        // );
        require(
            _tokenOwners[tokenId] == from,
            "From address must be the current owner"
        );
        _transfer(from, to, tokenId);
        _tokenOwners[tokenId] = to;
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        _transferOwnership(newOwner);
    }

    function getCurrentTokenId() public view returns (uint256) {
        return _tokenId;
    }

    function setTokenURI(uint256 tokenId, string memory uri) public {
    //  require(_isApprovedOrOwner(msg.sender, tokenId), "Not approved or owner");
     _setTokenURI(tokenId, uri);
   }

   function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId), "Token does not exist");
        _tokenURIs[tokenId] = uri;
    }function _exists(uint256 tknId) internal returns (bool) {
        if(tknId <= _tokenId) return true;
        else return false;
    }
    
}
