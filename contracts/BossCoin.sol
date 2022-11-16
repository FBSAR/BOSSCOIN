// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ConvertLib.sol";
import "./ErrorsLib.sol";
import "./ERC20.sol";

contract BossCoin is ERC20 {

  address public minter;
  
  mapping (address => uint) public balances;
  mapping(address => mapping(address => uint)) public allowance;
  
  string public name = "BossCoin";
  string public symbol = "boss";
  string public tokenImage = 'https://final-boss-logos.s3.us-east-2.amazonaws.com/Logo_2.png';


  // 18 is default amount of decimals
  // uint8 public decimals = 18;
  uint8 public decimals = 0;

  event FinalBossWebRegistration(address indexed _to);
  event ParadoxTrainingWin(address indexed _to);

  constructor() {
    minter = tx.origin;
    // 120520000 = Amount of ETH in circulation as of 11/2022
    balances[minter] = 1000000;
  }

  function totalSupply() external view returns (uint) {
    return balances[minter];
  }

  function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
  }

  function balanceOf(address account) public view returns (uint) {
        return balances[account];
  }

  function transfer(address recipient, uint amount) external returns (bool) {
        balances[minter] -= amount;
        balances[recipient] += amount;
        emit Transfer(minter, recipient, amount);
        return true;
  }

  function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        // allowance[sender][msg.sender] -= amount;
        balances[sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
  
  function mint(uint amount) external returns (uint) {
      emit Transfer(address(0), minter, amount);
      balances[minter] += amount;
      return balances[minter];
  }

  function burn(uint amount) external returns (uint) {
      emit Transfer(minter, address(0), amount);
      balances[minter] -= amount;
      return balances[minter];
  }

  // Paradox Hazard Methods --

  // When a Gamer wins the training level, they earn 1 baus.
  // TODO: User can only earn this once.
  // TODO: Test 
  // For Ganache, use accounts[8] for testing purpurses.
  function trainingLevelWin(address reciever) public {
    this.transfer(reciever, 10);
    emit ParadoxTrainingWin(reciever);
  }

}
