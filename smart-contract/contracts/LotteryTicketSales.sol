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


// Contract to manage lottery ticket purchases
contract LotteryTicketSales is ERC2771Context {
    event TicketPurchased(address indexed buyer, uint256 amount, uint256 ticketNumber);

    constructor(address _trustedForwarder) ERC2771Context(_trustedForwarder) {}

    // Function to buy a lottery ticket
    function buyTicket(uint256 ticketNumber) external payable {
        require(msg.value == 0.01 ether, "LotteryTicketSales: Each ticket costs 0.01 ETH");

        // Emitting event that logs ticket purchase
        emit TicketPurchased(_msgSender(), msg.value, ticketNumber);
    }

    // Override _msgSender and _msgData to utilize ERC2771Context for meta-transactions
    function _msgSender() internal view override returns (address sender) {
        sender = super._msgSender();
    }

    function _msgData() internal view override returns (bytes calldata) {
        return super._msgData();
    }
}
