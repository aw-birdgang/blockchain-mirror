// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// 로또 계약
contract LotteryTicketContract {
    uint256 private ticketIdCounter = 1;

    // 이벤트 정의
    event TicketPurchased(uint256 indexed ticketNumber, address indexed buyer, uint256 drawNumber, uint256[] lottoNumbers, uint256 amountPaid);

    function buyTicket(uint256 drawNumber, uint256[] calldata lottoNumbers, uint256 amountPaid, address buyer) external {
        uint256 ticketNumber = ticketIdCounter++;
        emit TicketPurchased(ticketNumber, buyer, drawNumber, lottoNumbers, amountPaid);
    }
}
