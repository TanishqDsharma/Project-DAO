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
     * will have to implement. This is also a function that our Dao contract will call to interact with any 
     * proposals it receives.
     */
    function dosome() external ;
}

contract Dao {

}