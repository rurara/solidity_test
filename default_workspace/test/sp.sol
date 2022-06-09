// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract sp {
    IERC20 SP;
// 0x583031D1113aD414F02576BD6afaBfb302140225

//     0xdD870fA1b7C4700F2BD7f44238821C26f7392148


// a 0x17F6AD8Ef982297579C203069C1DbfFE4348c372
    constructor(address contractAddress) public{
        SP = IERC20(contractAddress);
    }

    function totalSupply_v1() public view returns(uint){
        
        return SP.totalSupply();
    }

    function balanceOf(address account) external view returns (uint){
        return SP.balanceOf(account);
    }
    function transfer(address recipient, uint amount) public returns(bool){
        return SP.transfer(recipient, amount);
    }
    function allowance(address owner, address spender) external view returns(uint){
        return SP.allowance(owner, spender);
    }

    function approve(address spender, uint amount) external returns(bool){
        return SP.approve(spender, amount);
    }
    function transferFrom(address spender, address recipient, uint amount) external returns(bool){
        return SP.transferFrom(spender, recipient, amount);
    }

    function transferFee(address recipient, uint amount, uint fee) public payable returns(bool){
        address spOwner = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
        uint commission = amount * fee / 100;
        uint realAmount = amount - commission;
        

        // return SP.transfer(recipient, realAmount);
        // bool realAmountFlag = SP.transfer(recipient, realAmount);
        if(SP.transfer(recipient, realAmount)){
            if(SP.transfer(spOwner, commission)){
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
}