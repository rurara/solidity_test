// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

import "./contracts/token/ERC721/ERC721.sol";
import "./contracts/token/ERC721/IERC721.sol";

import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721URIStorage.sol";


interface IPNFT721{
    function mint(address recipient, uint256 tokenId, string memory tokenURI) external;
}

contract PNFT is Ownable, ERC721URIStorage, IPNFT721 {      
    
    constructor() ERC721("yayahoho", "YAHO") {
    } 
    function mint(address recipient, uint256 tokenId, string memory tokenURI) public override{
        _mint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);        
    }
}

contract pProjectController{
    IPNFT721 pnft;
    address _nftContractAddress;

    constructor(address nftContractAddress){
        _nftContractAddress = nftContractAddress;
        pnft = IPNFT721(nftContractAddress);
    }

    function generateProjectNFT(address recipient, uint256 nftId, string memory tokenURI) public {
        pnft.mint(recipient, nftId, tokenURI);
    }
    function test() public view returns(uint256){
        return 11;
    }
    
}