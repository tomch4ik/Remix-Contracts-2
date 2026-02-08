// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IQuest {
    function startQuest(uint256 questId) external;
    function completeQuest(uint256 questId) external;
    function getReward(uint256 questId) external view returns (uint256);
}

contract QuestManager is IQuest {
    struct Player {
        uint256 level;
        uint256 experience;
        mapping(uint256 => bool) activeQuests;
    }

    mapping(address => Player) public players;
    mapping(uint256 => uint256) public questRewards;

    constructor() {
        questRewards[1] = 100; 
        questRewards[2] = 200; 
    }

    function startQuest(uint256 _questId) external override {
        require(!players[msg.sender].activeQuests[_questId], "Quest already started");
        players[msg.sender].activeQuests[_questId] = true;
    }

    function completeQuest(uint256 _questId) external override {
        require(players[msg.sender].activeQuests[_questId], "Quest not active"); 
        players[msg.sender].activeQuests[_questId] = false;
        players[msg.sender].experience += 100;
        players[msg.sender].level = players[msg.sender].experience / 200;
    }

    function getReward(uint256 _questId) external view override returns (uint256) {
        return questRewards[_questId];
    }
}