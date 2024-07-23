//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

///////////////////////
/// Interface's//////// 
/////////////////////// 

/** 
 * @notice  This ITargetContract will be a standard that each proposal contract submitted to our Dao contract
 * needs to follow.
 */

interface  ITargetContract  {

    /**
     * The dosome function is a standard function that any proposal following the ITargetContract interface 
       will have to implement. This is also a function that our Dao contract will call to interact with any 
       proposals it receives.
     */
    function dosome() external ;
}

contract Dao {

/////////////////////
/// State Vars //////
///////////////////// 

/**
 * Since our DAO contract only executes a proposal if it receives the majority vote from all participating members, 
   it's essential to keep track of all participating members and their corresponding voting power, aka balance.
 */
mapping(address=>uint256) public memberBalances;
uint256 public totalBalance; //The amount of votes needed to pass a proposal is proportional to the totalBalance.

uint256 public proposalCount; // Assign an ID to this proposal the user is trying to create.

mapping(uint256=>Proposal) public proposals; //mapping to store and find proposals by ID



/**
 * creator variable represents the address of the account that created the proposal.
 * description is a short message that describes the proposal.
 * votes variable counts the “yes” votes received so far.
 * executed variable says whether the proposal has been executed or not.
 * targetAddress is the address of the proposal contract that we will execute if voting passes.
 */

struct Proposal{
    address creator;
    string description;
    uint256 votes;
    bool executed;
    address targetAddress;
}


//////////////////////
//External Functions// 
////////////////////// 

/**
 * 
 * @param memberAddress  is the address of a member we are adding to our DAO contract
 * @param balance  is the amount of funds associated with this member
 */

function mockBalance(
    address memberAddress, 
    uint256 balance) external{
        memberBalances[memberAddress] = balance;
        totalBalance+=balance;
}

function createProposal(
    string memory description, address target) 
        external {
        //we create a local variable, proposalId, initialized with proposalCount, which is then incremented to ensure uniqueness.
        uint256 proposalId = proposalCount++;
        Proposal storage proposal = proposals[proposalId];
        proposal.creator=msg.sender;
        proposal.description=description;
        proposal.votes=0;
        proposal.executed=false;
        proposal.targetAddress=target;
}

}

contract Proposal1{

    /**
     * @notice This will be a check for dosome function whether it is called or not.
     */
    bool public flag=false;

    // We would like the DAO contract to interact with the Proposal1 contract via the dosome function
    function dosome() public{
        flag=true;
    }
}