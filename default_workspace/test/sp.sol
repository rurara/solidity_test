// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}


contract sp {
    IERC20 SP;
// 0x583031D1113aD414F02576BD6afaBfb302140225

//     0xdD870fA1b7C4700F2BD7f44238821C26f7392148


// a 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// b 0xdD870fA1b7C4700F2BD7f44238821C26f7392148

// 0xa9059cbb000000000000000000000000dd870fa1b7c4700f2bd7f44238821c26f73921480000000000000000000000000000000000000000000000000000000000000004
// 0x23b872dd0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4000000000000000000000000dd870fa1b7c4700f2bd7f44238821c26f73921480000000000000000000000000000000000000000000000000000000000000004
    constructor(address contractAddress) public{
        SP = IERC20(contractAddress);
    }
    function doStuff() external {
        address from = msg.sender;

        SP.transferFrom(address(this), from, 1);

        
    }
    function thisA() public view returns(address){
        return address(this);
    }
    function self() public view returns(uint){
            // uint256 dexBalance = SP.balanceOf(address(this));

        return SP.balanceOf(msg.sender);
        // return dexBalance;
    }
    function totalSupply_v1() public view returns(uint){
        
        return SP.totalSupply();
    }

    function balanceOf(address account) external view returns (uint){
        return SP.balanceOf(account);
    }
    function transfer(address recipient, uint amount) external returns(bool){
        SP.approve(msg.sender, amount);
        SP.approve(recipient, amount);
        return SP.transfer(recipient, amount);
    }
    function allowance(address owner, address spender) external view returns(uint){
        return SP.allowance(owner, spender);
    }

    function approve(address spender, uint amount) external returns(bool){
        return SP.approve(spender, amount);
    }
    function transferFrom(address spender, address recipient, uint amount) external returns(bool){
        SP.approve(msg.sender, amount);
        SP.approve(recipient, amount);
        return SP.transferFrom(spender, recipient, amount);
    }

    function transferFee(address recipient, uint amount, uint fee) public returns(bool){
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