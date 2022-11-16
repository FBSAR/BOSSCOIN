// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// These files are dynamically created at test time
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BossCoin.sol";

contract TestBossCoin { 
  function testInitalBalancesUsingDeployedContract() public {
    BossCoin boss = BossCoin(DeployedAddresses.BossCoin());

    uint expected = 120520000 - 201;

    Assert.equal(boss.balanceOf(tx.origin), expected, 'Owner should have 120,520,000 BossCoin initially.');
  }

  function testInitialBalanceWithNewBossCoin() public {
    BossCoin boss = new BossCoin();

    uint expected = 120520000;

    Assert.equal(boss.balanceOf(tx.origin), expected, "Owner should have 120,520,000 BossCoin initially");
  }
}