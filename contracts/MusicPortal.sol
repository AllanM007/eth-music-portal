// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MusicPortal {

    uint256 totalShazams;

    /*
     * A little magic, Google what events are in Solidity!
     */
    event NewMusic(address indexed from, uint256 timestamp, string message);

    /*
     * I created a struct here named Music.
     * A struct is basically a custom datatype where we can customize what we want to hold inside it.
     */

    struct Music {
        address shazamer; // The address of the user who shazamed.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    /*
     * I declare a variable waves that lets me store an array of structs.
     * This is what lets me hold all the waves anyone ever sends to me!
     */
    Music[] musics;

    constructor(){
        console.log("I am Music Portal Smart Contract");
    }
    
    function shazam( string memory _message) public{
        totalShazams += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);
        /*
         * This is where I actually store the wave data in the array.
         */
        musics.push(Music(msg.sender, _message, block.timestamp));

        /*
         * I added some fanciness here, Google it and try to figure out what it is!
         * Let me know what you learn in #general-chill-chat
         */
        emit NewMusic(msg.sender, block.timestamp, _message);
    }

    function getAllShazams() public view returns (Music[] memory) {
        return musics;
    }

    function getTotalShazams() public view returns (uint256) {
        console.log("We have %d total shazams!", totalShazams);
        return totalShazams;
    }
}