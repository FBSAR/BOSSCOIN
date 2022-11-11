// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ConvertLib.sol";
import "./ErrorsLib.sol";
import "./ERC20.sol";

contract BossCoin is ERC20 {

  address public minter;
  uint public totalSupply;
  mapping (address => uint) public balances;
  mapping(address => mapping(address => uint)) public allowance;
  string public name = "BossCoin";
  string public symbol = "bossc";

  // 18 is default amount of decimals
  // uint8 public decimals = 18;
  uint8 public decimals = 0;

  event CoinTransferFromMinter(address indexed _from, address indexed _to, uint256 _value);
  event CoinTransferFromUser(address indexed _from, address indexed _to, uint256 _value);
  event FinalBossWebRegistration(address indexed _to);
  event ParadoxTrainingWin(address indexed _to);

  constructor() {
    minter = tx.origin;
    // 120520000 = Amount of ETH in circulation as of 11/2022
    balances[minter] = 120520000;
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
  
  function mint(uint amount) external {
      balances[minter] += amount;
      totalSupply += amount;
      emit Transfer(address(0), minter, amount);
  }

  function burn(uint amount) external {
      balances[minter] -= amount;
      totalSupply -= amount;
      emit Transfer(minter, address(0), amount);
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
