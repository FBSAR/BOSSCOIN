const BossCoin = artifacts.require("BossCoin");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("BossCoin", (accounts) => {
  it("should but 10,000,000 BossCoin in the original account", async () => {
    const bossCoinInstance = await BossCoin.deployed();
    const originalBalance = (await bossCoinInstance.getBalance.call(accounts[0])).toNumber();

    assert.equal(originalBalance.valueOf(), 10000000, '10,000,000 was not initial account')
  });
  it("should send coins correctly", async () => {
    const bossCoinInstance = await BossCoin.deployed();

    // Setup 2 accounts
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    // Get initial balances of first and second account
    const accountOneStartingBalance = (await bossCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoStartingBalance = (await bossCoinInstance.getBalance.call(accountTwo)).toNumber();

    // Make transaction from first account to second
    const amount = 100;
    await bossCoinInstance.sendCoin(accountTwo, amount, { from: accountOne})

    // Get balances of two accounts after transactions.
    const accountOneEndingBalance = (await bossCoinInstance.getBalance.call(accountOne)).toNumber();
    const accountTwoEndingBalance = (await bossCoinInstance.getBalance.call(accountTwo)).toNumber();

    assert.equal(accountOneEndingBalance, accountOneStartingBalance - amount, 'Amount wasnt correctly taken from the sender');
    assert.equal(accountTwoEndingBalance, accountTwoStartingBalance + amount, 'Amount wasnt correctly taken from the receiver');
  });
  it("should send a registering user on finalbossar.com one BossCoin", async () => {
    const bossCoinInstance = await BossCoin.deployed();

    // Setup Orinal Account & It's Initial Balance
    const originalAccount = accounts[0];
    const originalAccountStartingBalance = (await bossCoinInstance.getBalance.call(originalAccount)).toNumber();

    // Setup Registering Account & Get it's initial balance
    const registeringAccount = accounts[1];
    const registeringAccountStartingBalance = (await bossCoinInstance.getBalance.call(registeringAccount)).toNumber();

    // Send user 1 boss coin for signing up with Finalbossar.com
    const amount = 1;
    await bossCoinInstance.sendCoin(registeringAccount, amount, {from: originalAccount});

    const originalAccountEndingBalance = (await bossCoinInstance.getBalance.call(originalAccount)).toNumber();
    const registeringAccountEndingBalance = (await bossCoinInstance.getBalance.call(registeringAccount)).toNumber();

    assert.equal(registeringAccountEndingBalance, registeringAccountStartingBalance + amount, 'registering account did not recieve coin')
    assert.equal(originalAccountEndingBalance, originalAccountStartingBalance - amount, 'original account did not send token to registering user')
  });
  it("should mint a set amount of new BossCoins correctly.", async () => {
    const bossCoinInstance = await BossCoin.deployed();
    const mintAmount = 100;
    const minterAddress = accounts[0];
    const minterBalance = (await bossCoinInstance.getBalance.call(minterAddress)).toNumber();
    const afterMintBalance =  (await bossCoinInstance.mintCoins.call(minterAddress, mintAmount)).toNumber();
    assert.equal(minterBalance + mintAmount, afterMintBalance, 'mintCoin function does not work.');
  });
  it("should import ErrorLib", async () => {
    const bossCoinInstance = await BossCoin.deployed();

    // Send more coin than user has available
    const amount = 1000000000;
    const account = accounts[1];
    // try {
    //   await bossCoinInstance.sendCoin(account, amount);
    // } catch (error) {
    //   assert(error, "Was expecting an error from ErrorLib");
    // }
    
  });

});
