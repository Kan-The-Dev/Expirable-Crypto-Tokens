// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ExpirableToken is ERC20 {
    address public owner;

    // Structure for tokens with expiry dates
    struct TokenExpiry {
        uint256 amount; // Amount of tokens assigned with an expiry
        uint256 expiryDate; // Expiry date (in UNIX timestamp)
    }

    mapping(address => TokenExpiry) public tokenExpiries;

    // Modifier to restrict actions to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    // Constructor that initializes the contract, sets the initial owner, name, and symbol
    constructor(string memory name, string memory symbol, address initialOwner)
        ERC20(name, symbol)
    {
        owner = initialOwner; // Set the owner
    }

    // Mint tokens with an expiry date
    function mintWithExpiry(address recipient, uint256 amount, uint256 expiryDate) external onlyOwner {
        require(expiryDate > block.timestamp, "Expiry date must be in the future");
        _mint(recipient, amount);
        tokenExpiries[recipient] = TokenExpiry(amount, expiryDate);
    }

    // Custom transfer function to check expiry before token transfer
    function transfer(address to, uint256 amount) public override returns (bool) {
        address from = msg.sender;
        TokenExpiry memory expiry = tokenExpiries[from];
        
        // Check if the sender's tokens have expired
        if (expiry.expiryDate > 0) {
            require(block.timestamp <= expiry.expiryDate, "Tokens have expired");
        }

        // Proceed with the transfer after expiry check
        return super.transfer(to, amount);
    }

    // Burn expired tokens for an account
    function burnExpiredTokens(address account) external onlyOwner {
        TokenExpiry memory expiry = tokenExpiries[account];
        require(expiry.expiryDate > 0, "No tokens with expiry for this account");
        require(block.timestamp > expiry.expiryDate, "Tokens are not expired yet");

        uint256 expiredAmount = expiry.amount;
        _burn(account, expiredAmount);
        delete tokenExpiries[account];
    }
}
