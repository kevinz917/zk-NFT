# zkNFT

Here I present zkNFT, a NFT powered by zero-knowledge proofs that flips the concept of an NFT upside down. Traditional NFTs contain metadata that are fully revealed. In essence, zkNFT allows users to create and prove ownership of NFTs and their characteristics without revealing the actual underlying metadata.

This would allow interesting universes to be built on top of the NFTs. For example, two pets, represented by NFTs and their hidden attributes, can engage in battle, but through ZK, can be orchestrated in a way such that the attributes are not fully revealed, but only the battle results are. In addition, zero knowledge creates unseen dynamics in trading described below.

## How it works

1. Minting
   User first select attributes for their NFT. In this prototype it means selecting three values such as speed, strength, and health. These attributes are then stored off-chain in a browser cache. To mint the NFT, a hash of the attributes is submitted along with a zero-knowledge proof to verify that the three attributes are within bounds specified by the protocol. For instance, the sum of the three abilities must be less than a max value.

2. Revealing and Trading
   Trading is an integral part of any NFT ecosystem, but how would people trade if the information is hidden? Here, we use a partial reveal schema that allows users to reveal a portion of their NFT's metadata without revealing the entire NFT, proven by zkSNARKs again. For example, seller A wants to prove to buyer B that seller A's NFT has an attribute of speed greater than 5, but not specifying what that value is. This partial reveal schema provides the necessary speculation to engage buyers and sellers in a fog-of-war type interaction we haven't seen anywhere else in the NFT world.

3. Revealing the entire NFT
   Users can fully reveal the characteristics of their NFTs and broadcast it on chain, potentially making their asset more desirable
# zk-NFT
