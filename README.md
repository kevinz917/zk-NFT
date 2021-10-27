# 🎲 Zero-knowledge NFT

Here I present **zk-NFT**, a NFT powered by [zkSNARKs](https://z.cash/technology/zksnarks/) that flips the concept of an NFT upside down. Normally, NFTs contain metadata that are fully revealed. Here, zk-NFT allows users to create and prove ownership of NFTs as well as their characteristics without revealing the full underlying metadata.

This would allow interesting universes to be built on top of the NFTs. For example, two pets, represented by NFTs and their hidden attributes, can engage in battle, but through ZK, can be orchestrated in a way such that the attributes are not fully revealed, but only the battle results are. In addition, this creates unseen dynamics in trading through a fog-of-war type interaction.

zkSNARKs written in [Circom](https://github.com/iden3/circom) and [Solidity](https://docs.soliditylang.org/en/v0.8.9/).

## How it works

Suppose Alice plays a video game (powered by zk-NFT). First, the game asks Alice to create her character (mint the NFT). The character has three attributes: speed, agility, and endurance, and the total of these attributes cannot exceed 10.

Alice then creates her character and keeps these attributes private (off-chain) to herself and submits a hash of it onchain (committing the zk proof). After a few hours, many other players such as Bob also create their own unique characters.

As the game progressed, many have realize that characters with high speed values are currently useful, and Alice happens to have a character like that. However, because the information is hidden, others don't know. Seeing that her character is desirable, Alice decides to sell it.

In order to create speculation and movement in the market, Alice partially reveals (using SNARKs) that her character indeed has a speed attribute above 7 (or any arbitrary value), but doesn't reveal exactly the number. This garners interest from buyers, and Bob decides to place a bid of 1 ETH. At the same time, Alice, without revealing the entire NFT, retains some leverage and information asymmetry.

Alice, seeing that Bob's bid is fair, accepts the bid and sells her character. When she accepts the bid, she hands over the right of the character, and is also bounded to simultaneously reveals all three attributes of her character. Bob is very happy - he knew that the speed attribute is higher than 7, and is pleased to find out that it's actually a 9, thinking he got a good deal. Alice, also thinks she got a decent deal, since the other attributes of her character, agility and endurance are very low (but she didn't have to reveal them to Bob), and she suspects that in the future, the game will value characters with high agility stats. She continues the cycle by trying to buy other unrevealed characters ...

## The Breakdown

1. **Minting**. User first select attributes for their NFT in private with some constrait. In this prototype, it means selecting three attributes for your character, and the sum of the attributes has to be less than a max value. These attributes are then stored off-chain in a browser cache. To mint the NFT, the proof for minting is submitted which contains hidden values of attributes.

2. **Revealing and Speculating** Trading is an integral part of any NFT ecosystem, but how would people trade if the information is hidden? Here, we use a partial reveal schema that allows users to first reveal a portion of their NFT's metadata without revealing the entire scheme, proven by zkSNARKs. For example, seller A wants to prove to buyer B that his NFT has an attribute of "speed" greater than 5 to encourage a purchase, but not specifying what that value is to retain leverage. This partial reveal schema provides the necessary speculation to engage buyers and sellers in a fog-of-war type interaction we haven't seen anywhere else in the NFT world.

3. **Trading**. In this version of the game, when a seller accepts a bid, they must reveal the full attributes of their NFT, effectively broadcasting it on-chain. It's possible to also swap the hidden attributes in off-chain ways. I'm currently exploring more trading variations!

## Future work

I'm broadly interested in exploring how ZK can play out in gaming and [community-owned characters](https://future.a16z.com/fantasy-hollywood-crypto-and-community-owned-characters/).

Please follow me [here](https://twitter.com/kzdagoof) and reach out [here](https://thekevinz.com/) to jam on ideas!
