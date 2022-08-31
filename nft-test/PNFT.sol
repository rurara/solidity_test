// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "./contracts/token/ERC721/ERC721.sol";
import "./contracts/token/ERC721/IERC721.sol";

import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721URIStorage.sol";


interface IPNFT721{
    function mint(address recipient, uint256 tokenId, string memory tokenURI) external;
}
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
contract PNFT is Ownable, ERC721URIStorage, IPNFT721 {      
    address _admin;
    constructor(address admin) ERC721("yayahoho", "YAHO") {
        _admin = 
    }
    
    //  transact to pProjectController.generatePERC721 errored: Error encoding arguments: Error: types/values length mismatch (count={"types":3,"values":4}, value={"types":["address","uint256","string"],"values":["0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB","67","{",":"]}, code=INVALID_ARGUMENT, version=abi/5.5.0)
    function mint(address recipient, uint256 tokenId, string memory tokenURI) public override{
    // function mint(address recipient, uint256 tokenId, string memory tokenURI) public override onlyOwner{
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

//todo :: onlyOwner setting
    function generatePERC721(address recipient, uint256 nftId, string memory tokenURI) public {
        pnft.mint(recipient, nftId, tokenURI);
    }

    function generateProjectNFT(address recipient, uint256 nftId,
        address captain//,
        // string coverImage,   
        // string description,
        // uint state,
        // uint quantity,
        // uint monthlyReward,
        // uint created,
        // uint updated
        ) public {

        address _captain = captain;
        // string _coverImage = coverImage;
        // string _description = description;
        // uint _state = state;
        // uint _quantity = quantity;
        // uint _monthlyReward = monthlyReward;
        // uint _created = created;
        // uint _updated = updated; 

        // string memory _uri = string.concat("{captain:",_captain);

        string memory _uri = string(abi.encodePacked("{captain", _captain));

        generatePERC721(recipient, nftId, _uri);


        // generatePERC721
    }


    function test() public pure returns(uint256){
        return 11;
    }
    
}