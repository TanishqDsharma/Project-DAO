# Project - DAO

--- In this project we will define a contract for our DAO and interface for our proposal.
    -- DAO is called Decentralized Autonomous Organization, and Autonomous means once the DAO has decided to do something, it will execute itself.
    -- In other words, once people have voted on some proposals, the proposal will execute itself. Therefore, we need the proposal to follow some standard so our DAO contract can call the function in the proposal and execute it once the proposal passes the voting.

NOTE: 
As we know we use interfaces to define standards:
* So we will be defining an interface for the proposals created in our DAO contract.


Dao.sol:
* This contract contains the main functionality of our DAO proposal voting and execution system.
    * Use an Interface to define standard for proposals.
    * This contract will have struct called Proposal, so that it can keep information about the proposals
    * Implmenting functions to add new DAO members and assigning them a balance
    * Allows each member to create a new proposal
    * Implementing Vote function that allows every member to vote on proposals
    * Executing a Proposal after it passed voting.

    

