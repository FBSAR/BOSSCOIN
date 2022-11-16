const BossCoin = artifacts.require("BossCoin");

module.exports = function(deployer) {
  deployer.deploy(BossCoin);
};
