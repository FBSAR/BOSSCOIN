const ConvertLib = artifacts.require("ConvertLib");
const BossCoin = artifacts.require("BossCoin");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, BossCoin);
  deployer.deploy(BossCoin);
};
