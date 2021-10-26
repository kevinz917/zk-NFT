import { expect } from "chai";
import { ethers as Ethers } from "ethers";
import { ethers } from "hardhat";
import { initMintProofsArgs, initMintWrongProofArgs, revertMessages, partialRevealNFTArgs, fullyRevealNFTArgs } from "./helper";

describe("ZK-NFT", () => {
  let nftContract: Ethers.Contract;
  let addr1: any;
  let addr2: any;
  let addr3: any;

  before(async () => {
    nftContract = await (await ethers.getContractFactory("ZKNFT")).deploy();
    [addr1, addr2, addr3] = await ethers.getSigners();
  });

  it("Mint ", async () => {
    await nftContract.mint(...initMintProofsArgs);
    expect(nftContract.mint(...initMintWrongProofArgs)).to.be.revertedWith(revertMessages.INVALID_PROOF);

    expect(await nftContract.balanceOf(addr1.address)).to.be.equal(1); // mint NFT

    const character = await nftContract.characters(0);
    expect(character.cHash).equal(initMintProofsArgs[3][0]);
    expect(character.isRevealed).equal(false);
  });

  it("Full reveal", async () => {
    await nftContract.reveal(...fullyRevealNFTArgs, 0);

    const character = await nftContract.characters(0); // verify character attribute reveal
    expect(character.isRevealed).equal(true);
    expect(character.attribute1).equal(fullyRevealNFTArgs[3][1]);
    expect(character.attribute2).equal(fullyRevealNFTArgs[3][2]);
    expect(character.attribute3).equal(fullyRevealNFTArgs[3][3]);
  });

  it("Partial reveal", async () => {
    await expect(nftContract.partialReveal1(...partialRevealNFTArgs, 0))
      .to.emit(nftContract, "PartialReveal")
      .withArgs(0, 1);
  });

  it("Create bid", async () => {
    expect(nftContract.createBid(0, { value: 1 })).to.be.revertedWith(revertMessages.SAME_OWNER); // addr1 cannot bid on it

    await nftContract.connect(addr2).createBid(0, { value: 10 }); // addr2 creates a bid
    expect(await nftContract.bids(0, addr2.address)).to.be.equal(10);
  });

  it("Accept bid", async () => {
    await nftContract.acceptBid(...fullyRevealNFTArgs, 0, addr2.address);
    expect(await nftContract.balances(addr1.address)).to.be.equal(10);
  });

  it("Withdraw funds", async () => {
    await nftContract.withdraw();
    expect(await nftContract.balances(addr1.address)).to.be.equal(0); // TODO: Add test balance
  });
});
