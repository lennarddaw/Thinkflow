const { expect } = require("chai");

describe("ThoughtChainToken", function () {
  it("should deploy and mint the initial supply", async function () {
    const [owner] = await ethers.getSigners();
    const ThoughtChainToken = await ethers.getContractFactory("ThoughtChainToken");
    const token = await ThoughtChainToken.deploy(ethers.utils.parseUnits("1000000", 18));
    await token.deployed();

    const balance = await token.balanceOf(owner.address);
    expect(balance).to.equal(ethers.utils.parseUnits("1000000", 18));
  });
});
