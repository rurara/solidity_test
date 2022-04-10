pragma solidity ^0.8.10;

contract Test {
    address public owner;

    constructor() public{
        owner = msg.sender;
    }

    function getSomeValue() public pure returns (uint256 value){
        return 5;
    }
}