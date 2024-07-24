//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Script} from "../lib/forge-std/src/Script.sol";
import {Dao,Proposal1} from "../src/Dao.sol";


contract DeployDAO is Script {

function run() external returns(Dao,Proposal1){
    vm.startBroadcast();
    Dao dao = new Dao();
    Proposal1 proposal = new Proposal1();
    vm.stopBroadcast();
    return (dao,proposal);
}
}