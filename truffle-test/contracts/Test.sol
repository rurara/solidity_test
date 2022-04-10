// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Test {
    struct BetInfo{
        uint256 answerBlockNumber;
        address payable bettor;
        bytes1 challenges;  //Prior to version 0.8.0, byte used to be an alias for bytes1.
    }
    address public owner;
    uint256 private _pot;
    uint256 private _tail;
    uint256 private _hand;

    mapping (uint256=>BetInfo) private _bets;
    uint256 constant internal BET_LIMIT = 256;
    uint256 constant internal BET_BLOCK_INTERVAL = 3;
    uint256 constant internal BET_AMOUNT = 5* 10 ** 15;

    event BET(uint256 index, address bettor, uint256 amount, bytes1 challenges, uint256 answerBlockNumber);

    constructor(){
        owner = msg.sender;
    }

    function getSomeValue() public pure returns (uint256 value){
        return 5;
    }

    function getPot() public view returns (uint256 pot) {
        return _pot;
    }

    // bet
    function bet(bytes1 challenges) public payable returns (bool result){
        require(msg.value == BET_AMOUNT, "show me the money");
        require(pushBet(challenges), "failed bet");

        emit BET(_tail -1, msg.sender, msg.value, challenges, block.number + BET_BLOCK_INTERVAL);

        return true;
    }
        //save queue
    // dist
        //check value

    function getBetInfo(uint256 index) public view returns (uint256 answerBlockNumber, address bettor, bytes1 challenges){
        BetInfo memory b = _bets[index];
        answerBlockNumber = b.answerBlockNumber;
        bettor = b.bettor;
        challenges = b.challenges;
    }

    function pushBet(bytes1 challenges) public returns (bool) {
        BetInfo memory b;
        b.bettor = payable(msg.sender);
        b.answerBlockNumber = block.number + BET_BLOCK_INTERVAL;
        b.challenges = challenges;
        
        _bets[_tail] = b;
        _tail++;

        return true;
    }

    function popBet(uint256 index) internal returns (bool){
        delete _bets[index];
        return true;
    }
}