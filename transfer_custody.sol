// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EvidenceManagement {
    // Define variables for evidence exchange
    address public custodian1;
    address public custodian2;
    string public evidenceHash;
    bool public evidenceTransferred;
    
    // Constructor function to initialize variables
    constructor(address _custodian1, address _custodian2) {
        custodian1 = _custodian1;
        custodian2 = _custodian2;
        evidenceTransferred = false;
    }
    
    // Function to transfer evidence hash
    function transferEvidence(string memory _evidenceHash) public {
        // Only custodians can transfer evidence
        require(msg.sender == custodian1 || msg.sender == custodian2, "Only custodians can transfer evidence");
        // Evidence can only be transferred once
        require(!evidenceTransferred, "Evidence has already been transferred");
        
        evidenceHash = _evidenceHash;
        evidenceTransferred = true;
    }
    
    // Function to retrieve evidence hash
    function getEvidenceHash() public view returns (string memory) {
        // Only custodians can retrieve evidence hash
        require(msg.sender == custodian1 || msg.sender == custodian2, "Only custodians can retrieve evidence hash");
        // Evidence must have been transferred
        require(evidenceTransferred, "Evidence has not been transferred");
        
        return evidenceHash;
    }
}
