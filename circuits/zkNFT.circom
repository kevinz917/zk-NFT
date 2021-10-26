include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/gates.circom"
include "../node_modules/circomlib/circuits/mimcsponge.circom"

// create NFTs that store data off chain and only hashed NFT metadata onchain. 
// Each user can mint NFTs with different attributes. Using ZK, these attributes will not able 
// to be viewed on chain directly for secrecy. For instance, these NFT's could represent characters 
// within a universe where a player doesn't want to reveal what their character's abilities are

// apply MiMC hash to attributes of the character
template hashCharacter() {
    signal private input attribute[3];
    signal output out;

    component mimc = MiMCSponge(3, 220, 1);
    mimc.ins[0] <== attribute[0];
    mimc.ins[1] <== attribute[1];
    mimc.ins[2] <== attribute[2];

    mimc.k <== 0;

    out <== mimc.outs[0];
}

// mint NFT. Users enter three attributes (private), which are stored locally in the browser. 
// A hash of the NFT is created along with a ZK proof to show that the three attributes satisfy
// a certain criteria.
template mint(MAX_VAL) {
    signal private input attribute1;
    signal private input attribute2;
    signal private input attribute3;

    signal output out; // hashed value of attributes

    // check whether attributes were less than or equan to X
    component l1 = LessEqThan(32);
    l1.in[0] <== attribute1 + attribute2 + attribute3;
    l1.in[1] <== MAX_VAL;

    l1.out === 1;

    // hash attribute
    component cHash = hashCharacter();
    cHash.attribute[0] <== attribute1;
    cHash.attribute[1] <== attribute2;
    cHash.attribute[2] <== attribute3;

    out <== cHash.out;
}

// users will be able to partially reveal the statistic of their NFT without revealing their own NFT
// ex: I want to reveal to other buyers that my NFT chararacters' attribute 1 value has
// at least x points. This engages buyers and sellers in a fog of war auction. Buyers won't know 
// exactly they're buying, but they know for certain some attributes at the same time, proven by zkSNARKs. 
// TODO: Generate more of the same type of circuits. They serve as speculation vehicles essentially
template revealAttribute(MIN_VAL) {
    signal private input attribute1;
    signal private input attribute2;
    signal private input attribute3;

    signal output out;

    // prove attribute1 is at least MIN_VAL
    component m1 = GreaterEqThan(32);
    m1.in[0] <== attribute1;
    m1.in[1] <== MIN_VAL;

    m1.out === 1;

    // hash attribute
    component cHash = hashCharacter();
    cHash.attribute[0] <== attribute1;
    cHash.attribute[1] <== attribute2;
    cHash.attribute[2] <== attribute3;

    out <== cHash.out;
}

// reveal NFT
template revealNFT() {
    signal input attribute1;
    signal input attribute2;
    signal input attribute3;

    signal output out;

    // hash attribute
    component cHash = hashCharacter();
    cHash.attribute[0] <== attribute1;
    cHash.attribute[1] <== attribute2;
    cHash.attribute[2] <== attribute3;

    out <== cHash.out;
}

component main = revealNFT();