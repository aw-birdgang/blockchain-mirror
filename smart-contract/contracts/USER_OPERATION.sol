// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define the UserOperation struct which is used across contracts
struct UserOperation {
    address sender;
    uint256 nonce;
    bytes callData;
    uint256 callGas;
    uint256 verificationGas;
    uint256 preVerificationGas;
    uint256 maxFeePerGas;
    uint256 maxPriorityFeePerGas;
    address paymaster;
    bytes paymasterData;
    bytes signature;
}
