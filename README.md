
# Ganache, MetaMask & Truffle Setup

* Launch a fresh bossCoinContract of Ganache

* Make sure truffig-config.js is configured for Ganache
    ** truffig-config.js > Network > Development
    ** development: {
            host: "127.0.0.1",
            port: 7545,           
            network_id: "5777",
    },

* In Truffle, make sure all Contracts are compiled and migrated
    ** Navigate to bossCoinContract directory in command line
    ** truffle --help to view all truffle commands
    ** truffle compile
    ** truffle migrate

* In a Command Line, run the command "truffle console"
    to use the local ganache bossCoinContract in the Truffle CLI.
    Make sure that the bossCoinContract's accounts matches the Ganache accounts,
    ** let accounts = await web3.eth.getAccounts()

* Open MetaMask

* In MetaMask, Settings > Networks
    ** Network Name: GanacheNET
    ** New RPC URL: [RPC Server URL in Ganache - usually HTTP:// 127.0.0.1:7545]
    ** Chain ID: [Network ID in Ganache]
    ** Currency symbol: ETH

* Add a Ganache Test Account
    ** Click Profile Icon > Import account
    ** Enter Private Key
        -- In Ganache, a private key can be found by clicking the key icon to the right of the index #.
    ** I usually add the Test Minter account first

* Import bossCoinContract (bossc)
    ** On each account, in the Assets tab, click "Import Token"
    ** Find the contract that created the original bossCoinContract contract. Usually the first or second block, depending on the order of the deploys in your migration. For example, if you deployed as such --> ConvertLib, bossCoinContract in that order, the contract that creats the original bossCoinContract contract would be on Block #2 since it was the second contract deployed inititally.
    ** Copy "Create Contract Address"
    ** In the Import Tokens window, paste the copied address to "Token Contract Address", with the correct Token Symbol & decimals. This will be the same process with the same address for every account to your import this coin to on MetaMask.

# Truffle Console commands for faster testing

* Contract instance details.

let bossCoinContract = await BossCoin.deployed()\
let contractAddress = bossCoinContract.address

* Converts a Metamask account's given balance, which is a string value, to a number. This helps for decimal/number conversions.

var metaMaskBalanceGorli = web3.eth.getBalance("0xbC4da83805800f31e27e920B8b800729D9403638").then(result => web3.utils.fromWei(result,"ether"));

* Set variables for all accounts
* Minter account is always accounts[0]

let accounts = await web3.eth.getAccounts()\
let ParadoxAccount = accounts[4]\
let FBSAccount = accounts[3]\
let testAccountTwo = accounts[2]\
let testAccount = accounts[1]\
let minterAccount = accounts[0]

* Get Total Supply of BossCoins.
var totalSupply = await bossCoinContract.totalSupply()\

* toNumber() converts a BigNum (BN) in JavaScript to an Integer
totalSupply.toNumber()

* Minter methods for adding and removing coins from totalSupply.

bossCoinContract.burn(999999)\
bossCoinContract.mint(999999)

* Get balance of specific accounts
* Be sure to differetiate between Ganache & Metamask accounts.

var balanceAccountOne = await bossCoinContract.balanceOf(testAccount)\
balanceAccountOne.toNumber()

var balanceAccountTwo = await bossCoinContract.balanceOf(testAccountTwo)\
balanceAccountTwo.toNumber()

var balanceFBSAccount = await bossCoinContract.balanceOf(FBSAccount)\
balanceFBSAccount.toNumber()

var balanceParadox = await bossCoinContract.balanceOf(ParadoxAccount)\
balanceParadox.toNumber()

* Transfer functions
* Require GAS

bossCoinContract.transfer(testAccount, 10000)\
balanceAccountOne.toNumber()\

bossCoinContract.transfer(testAccountTwo, 10)\
balanceAccountTwo.toNumber()

bossCoinContract.transferFrom(testAccount, testAccountTwo, 1)\

bossCoinContract.transferFrom(testAccountTwo, testAccount, 1)

bossCoinContract.transferFrom(testAccountTwo, minterAccount, 1000)

bossCoinContract.transferFrom(testAccount, minterAccount, 1000)


* FinalBossAR.com Methods

bossCoinContract.finalBossWebRegistration(FBSAccount)
balanceFBSAccount.toNumber()

* Paradox Hazard Methods

bossCoinContract.trainingLevelWin(ParadoxAccount)\
balanceParadox.toNumber()
