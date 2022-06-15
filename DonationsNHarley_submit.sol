// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;
    

contract CharityDonation {
    // Store variables
    string public donationName;
    uint public targetAmount;
    address public owner;
    uint public totalDonations;

    // Record here who makes a donation via mapping
    mapping(address => uint) public donations;

    //Name of the charity & target amount to raise so donors can check later
    constructor (string memory _donationName, uint _targetAmount) {
            donationName = _donationName;
            targetAmount = _targetAmount;
            owner = msg.sender;
        }
    
    // Check to see if target has been achieved
    modifier checkIfTargetMet(){
        require(totalDonations < targetAmount, "We have closed for taking Donations");
        _;
    }

    // For security require funds can only be taken by the contract owner
    modifier isOwner() {
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    // Make a donation
    function donate() checkIfTargetMet public payable{ 
        totalDonations += msg.value;
        donations[msg.sender] = msg.value;
    }

    // Get the donated funds from the contract
    function releaseMyMoney(address payable _to, uint _amount) isOwner public payable {
        require(totalDonations > 0, "You don't have enough donations yet");
        _to.transfer(_amount);

    }
}

