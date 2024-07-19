// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import '@openzeppelin/contracts/access/Ownable.sol';
contract SupNFT is ERC721, Ownable{
    mapping(uint256 => string) private _tokenURIs;
    uint256 tokenId=1;
   constructor() ERC721("SupNFT", "SUP") {}

   function totalSupply() public view returns (uint256) {
        return tokenId;
   }

   function mint(string memory uri) public returns (uint256){
     tokenId++;
     uint256 newTokenId = tokenId;
     _mint(msg.sender, newTokenId);
     _setTokenURI(newTokenId, uri);
      
      return newTokenId;
   } 

   function mintTo(address to) public returns (uint256){
     tokenId++;
     uint256 newTokenId = tokenId;
     _safeMint(to, newTokenId);
      return newTokenId;
   }

   function setTokenURI(uint256 tknId, string memory uri) public {
     require(_isApprovedOrOwner(msg.sender, tknId), "Not approved or owner");
     _setTokenURI(tokenId, uri);
   }

   function _setTokenURI(uint256 tknId, string memory uri) internal {
        require(_exists(tknId), "Token does not exist");
        _tokenURIs[tokenId] = uri;
    }
}