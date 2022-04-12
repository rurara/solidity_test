// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Test {
    struct BetInfo{
        uint256 answerBlockNumber;
        address payable bettor;
        bytes1 challenges;  //Prior to version 0.8.0, byte used to be an alias for bytes1.
    }
    address payable public owner;
    uint256 private _pot;
    uint256 private _tail;
    uint256 private _head;

    bool private develop = true;
    bytes32 answerForTest;

    mapping (uint256=>BetInfo) private _bets;
    uint256 constant internal BET_LIMIT = 256;
    uint256 constant internal BET_BLOCK_INTERVAL = 3;
    uint256 constant internal BET_AMOUNT = 5* 10 ** 15;

    enum BlockStatus { checkable, NotRevealed, BlockLimitPassed }
    enum BettingResult {Fail, Win, Draw}

    event BET(uint256 index, address bettor, uint256 amount, bytes1 challenges, uint256 answerBlockNumber);
    event WIN(uint256 index, address bettor, uint256 amount, bytes1 challenges, uint256 answerBlockNumber);
    event DRAW(uint256 index, address bettor, uint256 amount, bytes1 challenges, uint256 answerBlockNumber);
    event FAIL(uint256 index, address bettor, uint256 amount, bytes1 challenges, uint256 answerBlockNumber);
    event REFUND(uint256 index, address bettor, uint256 amount, bytes1 challenges, uint256 answerBlockNumber);
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
    function distribute() public {
        uint256 cur;
        uint transferAmount;

        BetInfo memory b;
        BlockStatus currentBlockStatus;
        for(cur=_head; cur<_tail; cur++){
            b = _bets[cur];
            currentBlockStatus = getBlockStatus(b.answerBlockNumber);


            if(currentBlockStatus == BlockStatus.checkable){

                bytes32 answerBlockHash = getAnswerBlockHash(b.answerBlockNumber)
                currentBlockResult = isMatch(b.challenges, answerBlockHash)


                if(currentBlockResult == BettingResult.Win){
                    transferAfterPayingFee(b.bettor, _pot + BET_AMOUNT)
                    _pot = 0;

                    emit WIN(cur, b.bettor, transferAmount, b.challenges, answerBlockHash[0], b.answerBlockNumber);

                }else if (currentBlockResult == BettingResult.Fail){
                    _pot +- BET_AMOUNT;
                    emit FAIL(cur, b.bettor, 0, b.challenges, answerBlockHash[0], b.answerBlockNumber);

                }else if (currentBlockResult == BettingResult.Draw){

                    transferAmount = transferAfterPayingFee(b.bettor, BET_AMOUNT);
                    emit DRAW(cur, b.bettor, transferAmount, b.challenges, answerBlockHash[0], b.answerBlockNumber);

                }
            } else if(currentBlockStatus == BlockStatus.NotRevealed){
                break;
            } else if(currentBlockStatus == BlockStatus.BlockLimitPassed){
                transferAmount = transferAfterPayingFee(b.bettor, BET_AMOUNT);
                    emit REFUND(cur, b.bettor, transferAmount, b.challenges, b.answerBlockNumber);
            }

            popBet(cur);
        }
        _head = cur;

        //check value
    }
    function transferAfterPayingFee(address payable addr, uint amount) internal returns (uint256){
        uint256 fee = amount / 100;
        uint256 amountFee= amount - fee;

        addr.transfer(amountFee);
        owner.transfer(fee);

        return amountFee;

    }

    function setAnswerForTest(bytes32 answer) public returns (bool result){
        require(msg.sender == owner, "only master")
        answerForTest = answer;
        return true;
    }
    function getAnswerBlockHash(uint256 answerBlockNumber) internal view returns(bytes32 answer){
        return develop ? answerForTest : blockhash(answerBlockNumber);
    }
    function isMatch(bytes1 challenges, bytes32 answer) public pure returns (BettingResult){
        bytes1 c1 = challenges;
        bytes1 c2 = challenges;

        bytes1 a1 = answer[0];
        bytes1 a2 = answer[0];

        c1 = c1 >> 4;
        c1 = c1 << 4;

        a1 = a1 >> 4;
        a1 = a1 << 4;

        c2 = c2 << 4;
        c2 = c2 >> 4;

        a2 = a2 << 4;
        a2 = a2 >> 4;

        if (a1 == c1 && a2 == c2){
            return BettingResult.Win;
        } else if(a1 == c1 || a2 == c2){
            return BettingResult.Draw;
        } else {
            return BettingResult.Fail;
        }



    }
    function getBlockStatus(uint256 answerBlockNumber) internal view returns(BlockStatus){
        if(block.number > answerBlockNumber && block.number < BET_LIMIT + answerBlockNumber){
            return BlockStatus.checkable;
        } else if(block.number <= answerBlockNumber){
            return BlockStatus.NotRevealed;
        } else if(block.number >= answerBlockNumber + BET_LIMIT){
            return BlockStatus.BlockLimitPassed;
        } 

        return BlockStatus.BlockLimitPassed;
    }

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