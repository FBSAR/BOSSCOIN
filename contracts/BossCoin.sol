// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ConvertLib.sol";
import "./ErrorsLib.sol";

contract BossCoin {
  address public minter;
  mapping (address => uint) balances;

  event Transfer(address indexed _from, address indexed _to, uint256 _value);

  constructor() {
    minter = msg.sender;
    balances[minter] = 10000000;
  }

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}

  function sendCoin(address reciever, uint amount) public {
    if(balances[msg.sender] < amount) {
      revert ErrorsLib.NotEnoughFunds(amount, balances[msg.sender]);
    }
    balances[msg.sender] -= amount;
    balances[reciever] += amount;
    emit Transfer(msg.sender, reciever, amount);
  }

  // function finalBossWebRegistration(address reciever, uint amount) public returns(bool sufficient) {

  // }

  modifier onlyMinter() {
    require(msg.sender == minter);
    _;
  }

  function mintCoins(address reciever, uint amount) public onlyMinter returns(uint) {
    
    balances[reciever] += amount;
    return balances[reciever];
  }
}
