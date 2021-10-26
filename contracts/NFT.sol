//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./partialRevealProof.sol";
import "./mintProof.sol";
import "./revealProof.sol";

struct character {
  uint256 attribute1;
  uint256 attribute2;
  uint256 attribute3;
  uint256 cHash;
  bool isRevealed;
}

contract ZKNFT is ERC721Enumerable, Ownable {
  RevealVerifier public revealVerifier;
  MintVerifier public mintVerifier;
  PartialRevealVerifier public partialRevealVerifier;

  mapping(uint256 => character) public characters;
  uint256 public tokenId = 0;

  event PartialReveal(uint256 _tokenId, uint256 _partialProofId);

  constructor() ERC721("zkNFT", "zkNFT") {
    transferOwnership(msg.sender);
    revealVerifier = new RevealVerifier();
    mintVerifier = new MintVerifier();
    partialRevealVerifier = new PartialRevealVerifier();
  }

  // mint NFT: User chooses three attributes in private that satisfy a certain criteria, for instance
  // they sum up to 20. Users can only mint for themselves.
  function mint(
    uint256[2] memory _a,
    uint256[2][2] memory _b,
    uint256[2] memory _c,
    uint256[1] memory _publicInputs
  ) public {
    require(mintVerifier.mintVerify(_a, _b, _c, _publicInputs), "Proof is not valid");
    _mint(msg.sender, tokenId);
    characters[tokenId].cHash = _publicInputs[0];
    characters[tokenId].isRevealed = false;
    tokenId++;
  }

  // reveal full NFT. Attributes will be fully revealed.
  function reveal(
    uint256[2] memory _a,
    uint256[2][2] memory _b,
    uint256[2] memory _c,
    uint256[4] memory _publicInputs,
    uint8 _tokenId
  ) public {
    require(revealVerifier.verifyRevealProof(_a, _b, _c, _publicInputs));
    require(characters[_tokenId].cHash == _publicInputs[0], "Invalid hash");
    characters[_tokenId].attribute1 = _publicInputs[1];
    characters[_tokenId].attribute2 = _publicInputs[2];
    characters[_tokenId].attribute3 = _publicInputs[3];
    characters[_tokenId].isRevealed = true;
  }

  // partial reveal
  // users can selectively reveal attributes about their NFT. For instance, they can prove that
  // a certain attribute is greater than X number, without revealing such attribute.
  // For the seller, this is effective in driving up speculation while maintaining leverage over information assymetry
  function partialReveal1(
    uint256[2] memory _a,
    uint256[2][2] memory _b,
    uint256[2] memory _c,
    uint256[1] memory _publicInputs,
    uint8 _tokenId
  ) public {
    require(partialRevealVerifier.verifyPartialRevealProof(_a, _b, _c, _publicInputs));
    require(characters[_tokenId].cHash == _publicInputs[0], "Invalid hash");
    emit PartialReveal(_tokenId, 1);
  }

  // TODO: Trading function
}
