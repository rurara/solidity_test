// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "./contracts/token/ERC721/ERC721.sol";
import "./contracts/token/ERC721/IERC721.sol";

// import "./contracts/access/Ownable.sol";
import "./contracts/token/ERC721/extensions/ERC721URIStorage.sol";


interface IPNFT721{
    function mint(address recipient, uint256 tokenId, string memory tokenURI) external;
}
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
contract PNFT is ERC721URIStorage, IPNFT721 {      
    address _admin;
    constructor() ERC721("yayahoho", "YAHO") {
        _admin = msg.sender;
    }
    
    function mint(address recipient, uint256 tokenId, string memory tokenURI) public override{
        require(_admin == msg.sender, "This function can only be used by admin");
        _mint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);        
    }
}

contract pReaderController{
    struct testStruct {
        string name;
        uint id;
    }

    struct Project{
        address captain;
        string coverImage;   /* cover image ipfs */
        string description;  /* html ipfs */
        uint state;          /* 0 - close, 10 - pending, 20- activate, 99- complete */
        uint quantity;       /* total quantity */
        uint monthlyReward;  /* first day */
        uint created;        /* timestamp */
        uint updated;        /* timestamp */
    }

    function getProject() public pure returns(Project memory){
        Project memory temp = Project(
            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            "cover image ipfs",
            "description ipfs",
            3,
            1000,
            10,
            1662026234,
            1662026234
        );

        return temp;
    }
    function getTestStruct() public pure returns(testStruct memory){
        testStruct memory asd = testStruct("name", 44);
        return asd;
    }

}

contract pProjectController{
    IPNFT721 pnft;
    address _nftContractAddress;
    address _admin;

    constructor(address nftContractAddress){
        _admin = msg.sender;
        _nftContractAddress = nftContractAddress;
        pnft = IPNFT721(nftContractAddress);
    }


    function generatePERC721(address recipient, uint256 nftId, string memory tokenURI) public {
        require(_admin == msg.sender, "This function can only be used by admin");
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
   }

    function test() public pure returns(uint256){
        return 11;
    }   
}