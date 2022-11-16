const { it } = require("node:test");

const BossCoin = artifacts.require("BossCoin");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("BossCoin", (accounts) => {
  it("should but 120,520,000 BossCoin in the original account", async () => {
    const bossCoinInstance = await BossCoin.deployed();
    const originalBalance = (await bossCoinInstance.balanceOf.call(accounts[0])).toNumber();

    assert.equal(originalBalance.valueOf(), 120520000, '120,520,000 was not initial account')
  });
  it("should send coins correctly", async () => {
    const bossCoinInstance = await BossCoin.deployed();

    // Setup 2 accounts
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account
    const accountOneStartingBalance = (await bossCoinInstance.balanceOf.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await bossCoinInstance.balanceOf.call(accountTwo)).toNumber();

    // Make transaction from first account to second
    const amount = 100;
    await bossCoinInstance.transfer(accountTwo, amount, { from: accountOne})

    // Get balances of two accounts after transactions.
    const accountOneEndingBalance = (await bossCoinInstance.balanceOf.call(accountOne)).toNumber();
    const accountTwoEndingBalance = (await bossCoinInstance.balanceOf.call(accountTwo)).toNumber();

    assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, 'Amount wasnt correctly taken from the sender');
    assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, 'Amount wasnt correctly taken from the receiver');
  });
  it("should send a registering user on finalbossar.com one BossCoin", async () => {
    const bossCoinInstance = await BossCoin.deployed();

    // Setup Orinal Account & It's Initial Balance
    const originalAccount = accounts[0];
    const originalAccountStartingBalance = (await bossCoinInstance.balanceOf.call(originalAccount)).toNumber();

    // Setup Registering Account & Get it's initial balance
    const registeringAccount = accounts[1];
    const registeringAccountStartingBalance = (await bossCoinInstance.balanceOf.call(registeringAccount)).toNumber();

    // Send user 1 boss coin for signing up with Finalbossar.com
    const amount = 1;
    await bossCoinInstance.transfer(registeringAccount, amount, {from: originalAccount});

    const originalAccountEndingBalance = (await bossCoinInstance.balanceOf.call(originalAccount)).toNumber();
    const registeringAccountEndingBalance = (await bossCoinInstance.balanceOf.call(registeringAccount)).toNumber();

    assert.equal(registeringAccountEndingBalance, registeringAccountStartingBalance + amount, 'registering account did not recieve coin')
    assert.equal(originalAccountEndingBalance, originalAccountStartingBalance - amount, 'original account did not send token to registering user')
  });
  it("should mint a set amount of new BossCoins correctly.", async () => {
    const bossCoinInstance = await BossCoin.deployed();
    const minterBalance = (await bossCoinInstance.balanceOf.call(accounts[0])).toNumber();
    const afterMintBalance = await bossCoinInstance.mint.call(100);
    assert.equal(afterMintBalance, minterBalance + 100, 'mint function does not work.');
  });
  it("should import ErrorLib", async () => {
    const bossCoinInstance = await BossCoin.deployed();

    // Send more coin than user has available
    const amount = 1000000000;
    const account = accounts[1];
    try {
      await bossCoinInstance.transfer(account, amount);
    } catch (error) {
      assert(error, "Was expecting an error from ErrorLib");
    }
    
  });
  // it("should be able to invoke all the necessary methods and properties for ERC-20 standard", async () => {
  //   const bossCoinInstance = await BossCoin.deployed();
  //   await bossCoinInstance.totalSupply();
  //   await bossCoinInstance.balanceOf(accounts[0]);
  //   await bossCoinInstance.transfer(accounts[1], 100);
  //   await bossCoinInstance.allowance(accounts[1], accounts[2]);
  //   await bossCoinInstance.approve(accounts[1], 100);
  //   await bossCoinInstance.transferFrom(accounts[1], accounts[2], 100);
  // });
});
