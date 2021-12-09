// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MusicPortal {

    uint256 totalShazams;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

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
     * I declare a variable shazams that lets me store an array of structs.
     * This is what lets me hold all the shazams anyone ever sends to me!
     */
    Music[] musics;

    constructor() payable {
        console.log("I am Music Portal Smart Contract");

        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }
    
    function shazam( string memory _message) public{
        totalShazams += 1;
        console.log("%s shazamed!", msg.sender);
        /*
         * This is where I actually store the shazam data in the array.
         */
        musics.push(Music(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a shazam
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed<= 50) {
            console.log("%s won!", msg.sender);

            /*
            * The same code we had before to send the prize.
            */
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

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