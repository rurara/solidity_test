// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "./contracts/token/ERC721/ERC721.sol";
import "./contracts/token/ERC721/IERC721.sol";

import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract PNFT is Ownable, ERC721URIStorage {      
    
    constructor() ERC721("yayahoho", "YAHO") {
    } 
    function mint(address recipient, uint256 tokenId, string memory tokenURI) public onlyOwner {        
        _mint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);        
    }
}


contract pProjectController {
    IERC721 pnft;
    address _nftContractAddress;
// 0xf8e81D47203A594245E36C48e151709F0C19fBe8
    constructor(address nftContractAddress){
        _nftContractAddress = nftContractAddress;
        pnft = IERC721(nftContractAddress);
    }

    function nftCount(uint256 tokenId) public view returns(address){
        return pnft.ownerOf(tokenId);
    }
        // function balanceOf(address owner) external view returns (uint256 balance);

    function bbb(address check) public view returns(uint256){
        return pnft.balanceOf(check);
    }
    function test() public view returns(uint256){
        return 10;
    }
    
}