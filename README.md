# Truffle Console commands for faster testing

let instance = await BossCoin.deployed()\
let accounts = await web3.eth.getAccounts()\
let WebAccount = accounts[9]\
let ParadoxAccount = accounts[8]\
let testAccount = accounts[7]\
let testAccountTwo = accounts[6]\
let minterAccount = accounts[0]\

instance.getBalance(minterAccount)\
instance.getBalance(WebAccount)\
instance.getBalance(ParadoxAccount\
instance.getBalance(testAccount)\
instance.getBalance(testAccountTwo)\

instance.finalBossWebRegistration(WebAccount)\
instance.trainingLevelWin(ParadoxAccount)\

instance.mintCoins(minterAccount, 1000)\
instance.deleteCoins(minterAccount, 1000)\

instance.sendCoinFromMinter(WebAccount, 1000)\
instance.sendCoinFromMinter(testAccount, 10)\
instance.sendCoinFromMinter(testAccountTwo, 10)\
instance.sendCoinFromUser(testAccount, testAccountTwo, 5)\

# Header