// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";

contract MyMetaTransactionContract is ERC2771Context {
    constructor(address _trustedForwarder) ERC2771Context(_trustedForwarder) {}

    function doSomethingImportant(string memory action) external {
        require(_msgSender() == tx.origin, "Unauthorized");
        // Your action here
    }
}