# ExpirableToken

## Overview

ExpirableToken is a Binance Smart Chain (BSC)-based smart contract that allows minting of tokens with an expiration date. Ideal for use cases like gaming vouchers, time-sensitive promotions, or rewards that need to expire after a specific period.

---

## Features

- **Expiring Tokens**: Mint tokens with a set expiry date, making them invalid after a certain time.
- **Ownership Control**: The contract owner can mint, transfer, and burn tokens.
- **Transfer Restrictions**: Tokens can't be transferred after their expiration date.
- **Burning Expired Tokens**: The owner can burn expired tokens.
- **BEP-20 Compatible**: Follows the BEP-20 token standard, similar to ERC-20.

---

## Functions

- **mintWithExpiry(address recipient, uint256 amount, uint256 expiryDate)**: Mint tokens with an expiration date.
- **transfer(address to, uint256 amount)**: Transfers tokens but checks if they are expired before proceeding.
- **burnExpiredTokens(address account)**: Burn expired tokens for a specific address.

---

## How to Deploy

1. **Compile the Contract** in Remix IDE using Solidity version `0.8.x`.
2. **Deploy** on BSC testnet/mainnet using **Injected Web3**.
3. **Interact** with the contract via Remix: Mint tokens, transfer them, and burn expired tokens.

---

## Example Use Cases

- **Gaming**: Time-limited rewards.
- **Vouchers**: Expiring discounts or offers.
- **Promotions**: Tokens for limited-time deals.
