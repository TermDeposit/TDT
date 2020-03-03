const TDT = artifacts.require("./TDToken.sol")

module.exports = function(deployer){
    deployer.deploy(TDT, 12000000);
}