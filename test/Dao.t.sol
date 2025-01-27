//SPDX-License-Identifier: MIT


pragma solidity ^0.8.16;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {DeployDao} from "../script/DeployDao.s.sol" ;
import {Dao,Proposal1} from "../src/Dao.sol";

contract DaoTests is Test{
DeployDao deployDao;
Dao dao;
Proposal1 proposal;

uint256 public constant STARTING_BALANCE = 10e18; 

address user  = makeAddr("USER");

    function setUp() public {
        deployDao= new DeployDao();
        (dao,proposal) = deployDao.run();
        vm.deal(user,STARTING_BALANCE);
    }


    //////////////////////
    ///MockBalance Tests//
    //////////////////////

    function testMockBalance() public {
        vm.startPrank(user);

        dao.mockBalance(user,1000);
        uint256 actualMemberBalance = dao.getMemberBalance();
        uint256 actualTotalBalance = dao.totalBalance();
        vm.stopPrank();

        assert(actualMemberBalance==1000);
        assert(actualTotalBalance==1000);
    }

    /////////////////////////////
    ///CreateProposal Tests /////
    /////////////////////////////

    function testCreateProposal() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        vm.stopPrank();
        (address creator,string memory description,,,) = dao.getProposals(0);
        assert(creator==user);
        assert(keccak256(abi.encode(description))==keccak256(abi.encode("Testing Proposals")));
     }

     ///////////////////////// 
     /// Vote Tests ////////// 
     ///////////////////////// 

     function testRevertsIfProposalHasBeenExecuted() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        dao.mockBalance(user, 100);
        dao.vote(0);
        dao.ExecuteProposal(0);
        vm.expectRevert();
        dao.vote(0);
        vm.stopPrank();
     }

     function testRevertsIfBalanceIsZero() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        dao.mockBalance(user, 0);
        vm.expectRevert();
        dao.vote(0);
        vm.stopPrank();
     }

     function testRevertsIfMemberVotesOnSameProposalAgain() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        dao.mockBalance(user, 100);
        dao.vote(0);

        vm.expectRevert();
        dao.vote(0);
        vm.stopPrank();
     }

     function testToCheckMemberVotesAreBeingRecorded() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        dao.mockBalance(user, 100);
        dao.vote(0);    
        (,,uint256 votes,,) = dao.getProposals(0);
        vm.stopPrank();
        assert(votes==100);
     }

    ///////////////////////////////
    ///ExecuteProposal Tests //////
    ///////////////////////////////

    function testRevertsIfInsufficientVotesRecived() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        dao.mockBalance(user, 100);
        vm.expectRevert();
        dao.ExecuteProposal(0); 
        vm.stopPrank();
    }

    function testExecuteProposal() public {
        vm.startPrank(user);
        dao.createProposal("Testing Proposals",address(proposal));
        dao.mockBalance(user, 100);
        dao.vote(0);
        dao.ExecuteProposal(0); 
        (,,,bool executed,) = dao.getProposals(0);
        vm.stopPrank();
        assert(executed==true);
    }
}