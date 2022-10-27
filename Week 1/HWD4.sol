//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

//@author Kunal Jha
//@title Simple implementation of "VolcanoCoin"

contract VolcanoCoin {

    uint256 public totalSupply = 10000;
    address public owner;
    mapping(address => uint256) public balances;
    mapping(address => Payment[]) public transactionHistory;

    event totalSupplyChanged(uint256 newTotalSupply);
    event transferComplete(uint256 _amount, address _recipient);

    struct Payment {
        address recipient;
        uint256 amount;
    }

    //@notice constructor function to initialise owner address and send the all the coins to owner 

    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    modifier onlyOwner {
        require (msg.sender == owner, "Only owner can call this function");
        _;
    }

    /**
    @notice function to show total supply of coins
    @return totalSupply 
    */

    function showTotalSupply() public view returns (uint) {
        return totalSupply;
    }

    /**
    @dev function to increase total supply by 1000
    @notice totalSupplyChanged is emitted with the new total supply
    */

    function increaseTotalSupply() public onlyOwner {
        totalSupply = totalSupply + 1000;
        emit totalSupplyChanged(totalSupply);
    }

    /**
    @dev function to show current user balance
    @param _owner user address
    @return returns user balance stored in balances mapping
    */

    function showBalances(address _owner) external view returns (uint256) {
        return balances[_owner];
    }

    /**
    @dev function for transferring coins to a different user address
    @param _recipient - recepient address
    @param _amount - amount, in VolcanCoin, to be transferred
    */

    function transfer( address payable _recipient, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Low Balance");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;

        emit transferComplete(_amount, _recipient);
    }

}

