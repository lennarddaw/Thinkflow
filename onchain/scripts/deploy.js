async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);
  
    const ThoughtChainToken = await ethers.getContractFactory("ThoughtChainToken");
    const token = await ThoughtChainToken.deploy(ethers.utils.parseUnits("1000000", 18));
    
    await token.deployed();
    console.log("ThoughtChainToken deployed to:", token.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  