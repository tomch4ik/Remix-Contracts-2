// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WarriorGuild {
    struct Warrior {
        string name;
        string class;
        uint256 health;
    }

    mapping(address => Warrior) public warriors;

    function _register(string memory _name, string memory _class) internal {
        warriors[msg.sender] = Warrior(_name, _class, 100);
    }

    function attack() public virtual pure returns (string memory) {
        return "Basic physical strike";
    }
}

contract Knight is WarriorGuild {
    function joinGuild(string memory _name) public {
        _register(_name, "Knight");
    }

    function attack() public pure override returns (string memory) {
        return "Knight uses Holy Shield: 20 damage + block!";
    }
}

contract Mage is WarriorGuild {
    function joinGuild(string memory _name) public {
        _register(_name, "Mage");
    }

    function attack() public pure override returns (string memory) {
        return "Mage casts Blizzard: 50 area damage!";
    }
}

contract Assassin is WarriorGuild {
    function joinGuild(string memory _name) public {
        _register(_name, "Assassin");
    }

    function attack() public pure override returns (string memory) {
        return "Assassin uses Stealth Strike: 100 critical damage!";
    }
}