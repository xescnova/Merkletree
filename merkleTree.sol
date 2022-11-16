
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/MerkleProof.sol";

contract merkle {
    bytes32 public MERKLE_ROOT= 0x70a63129da00805718e0dabb2e1e1546f6a3c81e4636c9c39e9ca209ac464082;
    uint256 magicNumber;


    function setHashRoot(bytes32 _newHashRoot) public {
        MERKLE_ROOT =_newHashRoot;
    }

    modifier allowed(bytes32[] calldata proof){
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        bool isAllowed = MerkleProof.verify(proof,MERKLE_ROOT,leaf);
        require(isAllowed,"No estas en la lista");
        _;
    }

    function saveNumber(uint256 _number, bytes32[] calldata proof) public allowed(proof) {
        magicNumber = _number;
    }

}