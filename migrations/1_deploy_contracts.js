const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const BossCoin = artifacts.require("BossCoin");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  // deployer.link(ConvertLib, MetaCoin);
  // deployer.deploy(MetaCoin);
  deployer.link(ConvertLib, BossCoin);
  deployer.deploy(BossCoin);
};
