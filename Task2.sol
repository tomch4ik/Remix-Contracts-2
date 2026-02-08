// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ResourceUtils {
    function calculateUpgradeCost(uint256 basePrice, uint256 currentLevel) internal pure returns (uint256) {
        return basePrice * (currentLevel + 1);
    }

    function optimizeGoldUsage(uint256 amount, uint256 energyLevel) internal pure returns (uint256) {
        if (energyLevel > 50) {
            return (amount * 85) / 100;
        }
        return amount;
    }
}

contract ResourceManager {
    using ResourceUtils for uint256;

    struct PlayerResources {
        uint256 gold;
        uint256 energy;
        uint256 buildingLevel;
    }

    mapping(address => PlayerResources) public resources;

    function fundPlayer() public payable {
        resources[msg.sender].gold += msg.value;
        resources[msg.sender].energy = 100;
    }

    function upgradeBuilding() public {
        uint256 basePrice = 0.001 ether;
        uint256 cost = basePrice.calculateUpgradeCost(resources[msg.sender].buildingLevel);
        uint256 finalCost = cost.optimizeGoldUsage(resources[msg.sender].energy);

        require(resources[msg.sender].gold >= finalCost, "Not enough gold");
        
        resources[msg.sender].gold -= finalCost;
        resources[msg.sender].buildingLevel += 1;
        resources[msg.sender].energy -= 10; 
    }
}