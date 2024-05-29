// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JannaToken is ERC20, Ownable {
    event TokensMinted(address indexed receiver, uint256 amount);

    struct Reward {
        string name;
        uint256 price;
    }
    Reward[] public rewards;

    constructor() ERC20("JannaToken", "JNN") Ownable(msg.sender) {
        _mint(msg.sender, 100000 * 10 ** decimals());

        rewards.push(Reward("1st", 50));
        rewards.push(Reward("2nd", 50));
        rewards.push(Reward("3rd", 100));
        rewards.push(Reward("4th", 150));
        rewards.push(Reward("5th", 200));
    }

    function mintTokens(address receiver, uint256 amount) public onlyOwner {
        _mint(receiver, amount);
        emit TokensMinted(receiver, amount);
    }

    function transferTokens(address receiver, uint256 amount) public {
        _transfer(msg.sender, receiver, amount);
    }

    function redeemTokensForReward(uint256 rewardIndex) public {
        require(rewardIndex < rewards.length, "Invalid reward index");

        Reward memory reward = rewards[rewardIndex];
        require(balanceOf(msg.sender) >= reward.price, "Not enough tokens, try again");

        _burn(msg.sender, reward.price);
        
    }

    function checkTokenBalanceOf(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function burnTokensByAmount(uint256 amount) public {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens, try again");
        _burn(msg.sender, amount);
    }
}
