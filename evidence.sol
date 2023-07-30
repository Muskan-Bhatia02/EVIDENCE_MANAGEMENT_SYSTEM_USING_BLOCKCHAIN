// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EvidenceCustody {
  struct User {
    string email;
    string password;
    address publicKey;
  }

  struct Evidence {
    string name;
    string description;
    string ipfsHash;
    string creationDate;
    string evidenceType;
    address owner;
    address custodian;
    bool isTransferred;
  }

  mapping(uint256 => Evidence) public evidences;
  uint256 public evidenceCount;

  mapping(address => User) public users;

  event EvidenceAdded(
    uint256 indexed id,
    string name,
    string description,
    string ipfsHash,
    string creationDate,
    string evidenceType,
    address indexed owner
  );

  event CustodyTransferred(
    uint256 indexed id,
    address indexed from,
    address indexed to
  );

  function addUser(
    string memory _email,
    string memory _password,
    address _publicKey
  ) public {
    require(users[msg.sender].publicKey == address(0), "User already exists");

    users[msg.sender] = User(_email, _password, _publicKey);
  }

  function authenticate(
    string memory _email,
    string memory _password,
    address _publicKey
  ) public view returns (bool) {
    User storage user = users[msg.sender];
    return keccak256(bytes(user.email)) == keccak256(bytes(_email)) &&
           keccak256(bytes(user.password)) == keccak256(bytes(_password)) &&
           user.publicKey == _publicKey;
  }

  function addEvidence(
    string memory _name,
    string memory _description,
    string memory _type,
    string memory _creationDate,
    string memory _ipfsHash,
    string memory _email,
    string memory _password,
    address _publicKey
  ) public {
    require(authenticate(_email, _password, _publicKey), "Authentication failed");

    evidenceCount++;
    evidences[evidenceCount] = Evidence(
      _name,
      _description,
      _ipfsHash,
      _creationDate,
      _type,
      msg.sender,
      address(0),
      false
    );

    emit EvidenceAdded(
      evidenceCount,
      _name,
      _description,
      _ipfsHash,
      _creationDate,
      _type,
      msg.sender
    );
  }
}