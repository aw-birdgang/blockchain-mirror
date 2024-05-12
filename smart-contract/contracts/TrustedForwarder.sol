// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/metatx/MinimalForwarder.sol";

// Extended TrustedForwarder with additional security features and logging
contract TrustedForwarder is MinimalForwarder {
    // Constructor can be empty, as the MinimalForwarder does not require any initial setup

    // Event to log forwarding actions for auditability
    event Forwarded(address indexed from, address indexed to, bytes indexed data);

    // Override the forward function to add custom security checks and logging
    function forward(bytes calldata req, bytes calldata signature) public override {
        // Perform the basic checks and forwarding from MinimalForwarder
        super.forward(req, signature);

        // Decode the request to log it or perform additional checks
        (address from, address to, uint256 value, uint256 gas, uint256 nonce, bytes memory data)
        = abi.decode(req, (address, address, uint256, uint256, uint256, bytes));

        // Additional security checks can be implemented here
        require(from != address(0), "TrustedForwarder: invalid sender address");

        // Log the forwarding action
        emit Forwarded(from, to, data);
    }
}
