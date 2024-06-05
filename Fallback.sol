// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract Fallback{
    event Received(address Sender, uint Value );
    event fallbackCalled(address Sender, uint value, bytes data);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
     
    fallback() external payable {
        emit fallbackCalled(msg.sender, msg.value, msg.data);
    }
}