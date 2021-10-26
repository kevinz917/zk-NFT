# 🎲 Zero-knowledge NFT

Here I present zkNFT, a NFT powered by zkSNARKs that flips the concept of an NFT upside down. Traditionally NFTs contain metadata that are fully revealed. Here, zkNFT allows users to create and prove ownership of NFTs as well as their characteristics without revealing the actual underlying metadata.

This would allow interesting universes to be built on top of the NFTs. For example, two pets, represented by NFTs and their hidden attributes, can engage in battle, but through ZK, can be orchestrated in a way such that the attributes are not fully revealed, but only the battle results are. In addition, this creates unseen dynamics in trading described below.

## How it works

1. Minting
   User first select attributes for their NFT in private with some constrait. In this prototype, it means selecting three attributes for your character, and the sum of the attributes has to be less than a max value. These attributes are then stored off-chain in a browser cache. To mint the NFT, the proof for minting is submitted which contains hidden values of attributes.

2. Revealing and Trading
   Trading is an integral part of any NFT ecosystem, but how would people trade if the information is hidden? Here, we use a partial reveal schema that allows users to first reveal a portion of their NFT's metadata without revealing the entire scheme, proven by zkSNARKs. For example, seller A wants to prove to buyer B that his NFT has an attribute of "speed" greater than 5 to encourage a purchase, but not specifying what that value is to retain leverage. This partial reveal schema provides the necessary speculation to engage buyers and sellers in a fog-of-war type interaction we haven't seen anywhere else in the NFT world.

3. Revealing the entire NFT
   When trading the NFT, the seller must reveal the full characteristics of their NFT, effectively broadcasting it on-chain.
