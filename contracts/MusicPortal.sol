// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MusicPortal {

    uint256 totalShazams;

    constructor(){
        console.log("Hello, from the other side");
    }
    
    function shazam() public{
        totalShazams += 1;
        console.log("A new song has been added", msg.sender);
    }

    function getTotalShazams() public view returns (uint256) {
        console.log("We have %d total waves!", totalShazams);
        return totalShazams;
    }
}