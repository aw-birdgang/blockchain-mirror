// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./USER_OPERATION.sol";

interface IForwarder {
    function verify(UserOperation calldata op, bytes calldata signature) external view returns (bool);
    function execute(UserOperation calldata op, bytes calldata signature) external payable returns (bool, bytes memory);
}

contract PaymasterContract {
    address public immutable forwarder;

    constructor(address _forwarder) {
        forwarder = _forwarder;
    }

    function payForTransaction(UserOperation calldata op, bytes calldata signature) external payable {
        require(IForwarder(forwarder).verify(op, signature), "Verification failed");
        (bool success,) = IForwarder(forwarder).execute(op, signature);
        require(success, "Execution failed");
    }
}
