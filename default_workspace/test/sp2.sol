// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// import "contracts/access/Ownable.sol";
// import "contracts/token/ERC20/ERC20.sol";


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract spToken is Ownable, ERC20 {
    constructor() ERC20("Gold", "GLD") { }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }
    function mintTest() public onlyOwner {
        _mint(msg.sender, 999999);
    }
    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }

    function transferFee(address recipient, uint amount, uint fee) public returns(bool){
        address spOwner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        uint commission = amount * fee / 100;
        uint realAmount = amount - commission;
        
        if(transfer(recipient, realAmount)){
            if(transfer(spOwner, commission)){

                return true;
            } else {

                //refund 
                return false;
            }
        } else {

            //refund
            return false;
        }
    }  
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4       10
    // 0x583031D1113aD414F02576BD6afaBfb302140225       999899
    // 0xdD870fA1b7C4700F2BD7f44238821C26f7392148       90
}