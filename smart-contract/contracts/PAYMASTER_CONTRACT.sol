// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./USER_OPERATION.sol";

interface IForwarder {
    function verify(UserOperation calldata op, bytes calldata signature) external view returns (bool);
    function execute(UserOperation calldata op, bytes calldata signature) external payable returns (bool, bytes memory);
}


/*
**/
contract PaymasterContract {
    address[] public paymasters; // 수수료를 지불하는 지갑 목록
    mapping(address => bool) public isPaymaster;

    address public immutable forwarder;

    modifier onlyPaymaster() {
        require(isPaymaster[msg.sender], "Not authorized");
        _;
    }

    constructor(address[] memory initialPaymasters) {
        for (uint i = 0; i < initialPaymasters.length; i++) {
            addPaymaster(initialPaymasters[i]);
        }
    }

    constructor(address _forwarder) {
        forwarder = _forwarder;
    }

    function addPaymaster(address paymaster) public onlyOwner {
        require(!isPaymaster[paymaster], "Already a paymaster");
        isPaymaster[paymaster] = true;
        paymasters.push(paymaster);
    }

    function removePaymaster(address paymaster) public onlyOwner {
        require(isPaymaster[paymaster], "Not a paymaster");
        isPaymaster[paymaster] = false;
        for (uint i = 0; i < paymasters.length; i++) {
            if (paymasters[i] == paymaster) {
                paymasters[i] = paymasters[paymasters.length - 1];
                paymasters.pop();
                break;
            }
        }
    }


    function payForTransaction(UserOperation calldata op, bytes calldata signature) external payable {
        require(IForwarder(forwarder).verify(op, signature), "Verification failed");
        (bool success,) = IForwarder(forwarder).execute(op, signature);
        require(success, "Execution failed");
    }


    function payForTransaction(UserOperation calldata op) public payable onlyPaymaster {
        require(msg.value >= op.value, "Insufficient value sent");

        // 트랜잭션 실행
        (bool success, ) = op.target.call{value: op.value, gas: op.gasLimit}(op.callData);
        require(success, "Transaction execution failed");

        // 남은 이더 반환 (가스비 제외)
        uint256 remainingBalance = address(this).balance;
        if (remainingBalance > 0) {
            payable(msg.sender).transfer(remainingBalance);
        }
    }

    function withdrawFunds(address payable to, uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Insufficient funds");
        to.transfer(amount);
    }

    receive() external payable {}

    fallback() external payable {}

}
