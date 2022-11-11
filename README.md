# Ganache, MetaMask & Truffle Setup
* Launch a fresh instance of Ganache
* Make sure truffig-config.js is configured for Ganache
    ** truffig-config.js > Network > Development
    ** development: {
            host: "127.0.0.1",
            port: 7545,           
            network_id: "5777",
    },
* In Truffle, make sure all Contracts are compiled and migrated
    -- truffle compile
    -- truffle migrate
* In a Command Line, run the command "truffle console"
    to use the local ganache instance in the Truffle CLI.
    Make sure that the instance's accounts matches the Ganache accounts,
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
* Import BossCoin (bossc)
    ** On each account, in the Assets tab, click "Import Token"
    ** Find the contract that created the original BossCoin contract. Usually the first or second block, depending on the order of the deploys in your migration. For example, if you deployed as such --> ConvertLib, BossCoin in that order, the contract that creats the original BossCoin contract would be on Block #2 since it was the second contract deployed inititally.
    ** Copy "Create Contract Address"
    ** In the Import Tokens window, paste the copied address to "Token Contract Address", with the correct Token Symbol & decimals. This will be the same process with the same address for every account to your import this coin to on MetaMask.

# Truffle Console commands for faster testing
let instance = await BossCoin.deployed()\
let accounts = await web3.eth.getAccounts()\
let ParadoxAccount = accounts[4]\
let FBSAccount = accounts[3]\
let testAccountTwo = accounts[2]\
let testAccount = accounts[1]\
let minterAccount = accounts[0]

instance.balanceOf(minterAccount)\
instance.balanceOf(FBSAccount)\
instance.balanceOf(ParadoxAccount\
instance.balanceOf(testAccount)\
instance.balanceOf(testAccountTwo)

instance.finalBossWebRegistration(FBSAccount)\
instance.trainingLevelWin(ParadoxAccount)

instance.mint(minterAccount, 1000)\
instance.burn(minterAccount, 1000)

instance.transfer(WebAccount, 1000)\
instance.transfer(testAccount, 10)\
instance.transfer(testAccountTwo, 10)\
instance.transferFrom(testAccountTwo, testAccount, 1)\
instance.transferFrom(testAccount, testAccountTwo, 1)\
instance.transfer(testAccount, testAccountTwo, 5)

