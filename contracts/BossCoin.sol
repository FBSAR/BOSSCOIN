// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ConvertLib.sol";
import "./ErrorsLib.sol";

contract BossCoin {
  address public minter;
  mapping (address => uint) balances;

  event CoinTransferFromMinter(address indexed _from, address indexed _to, uint256 _value);
  event CoinTransferFromUser(address indexed _from, address indexed _to, uint256 _value);
  event FinalBossWebRegistration(address indexed _to);
  event ParadoxTrainingWin(address indexed _to);

  constructor() {
    minter = msg.sender;
    balances[minter] = 10000000;
  }

  // Minter Methods
  // Only the Minter can use Functions with this modifier.
  modifier onlyMinter() {
    require(msg.sender == minter);
    _;
  }

  // Add BossCoins to the Minter Account (original contract creating account)
  function mintCoins(address reciever, uint amount) public onlyMinter returns(uint) {
    balances[reciever] += amount;
    return balances[reciever];
  }

  // Delete Bosscoins from Minter Account
  function deleteCoins(address reciever, uint amount) public onlyMinter returns(uint) {
    balances[reciever] -= amount;
    return balances[reciever];
  }

	function getBalance(address addr) public view returns(uint) {
    return balances[addr];
	}

  // Used for sending BossCoin from Minter to User
  // TODO: Test 
  function sendCoinFromMinter(address reciever, uint amount) public onlyMinter {
    if(balances[minter] < amount) {
      revert ErrorsLib.MinterNotEnoughFunds(amount, balances[minter]);
    }
    balances[minter] -= amount;
    balances[reciever] += amount;
    emit CoinTransferFromMinter(minter, reciever, amount);
  }

  // Used for sending BossCoin from User to User
  // Used accounts[1] & accounts[2] for testing.
  // TODO: Test 
  function sendCoinFromUser(address sender, address reciever, uint amount) public {
    if(balances[sender] < amount) {
      revert ErrorsLib.UserNotEnoughFunds(amount, balances[msg.sender]);
    }
    balances[sender] -= amount;
    balances[reciever] += amount;
    emit CoinTransferFromUser(sender, reciever, amount);
  }

  // FinalBossAR Methods --

  // When a User registers for FinalBossAR.com, they have the option of
  // recieving 1 baus
  // TODO: User can only earn this once.
  // TODO: Test 
  // For Ganache, use account[9] for testing purpurses.
  function finalBossWebRegistration(address reciever) public {
    this.sendCoinFromMinter(reciever, 1);
    emit FinalBossWebRegistration(reciever);
  }

  // Paradox Hazard Methods --

  // When a Gamer wins the training level, they earn 1 baus.
  // TODO: User can only earn this once.
  // TODO: Test 
  // For Ganache, use accounts[8] for testing purpurses.
  function trainingLevelWin(address reciever) public {
    this.sendCoinFromMinter(reciever, 10);
    emit ParadoxTrainingWin(reciever);
  }

}
