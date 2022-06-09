// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// import "contracts/access/Ownable.sol";
// import "contracts/token/ERC20/ERC20.sol";


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract spToken is Ownable, ERC20 {
    constructor() public ERC20("Gold", "GLD") { }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }
}