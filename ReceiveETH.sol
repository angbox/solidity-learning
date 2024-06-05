// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract ReceiveETH{
    event Log(uint amount, uint gas);

    //receive方法，接收eth的时候被触发
    receive() external payable { 
       emit Log(msg.value, gasleft()); 
    }

    //返回合约ETH余额
    function getBalance() view public returns(uint){
        return address(this).balance;
    }

}
contract SendETH{
    constructor() payable {}
    //receive方法接收eth时触发
    receive() external payable { }
    //用transfer()发送ETH
    // function transferETH(address payable _to, uint256 amount) external payable{
    // //发送ETH
    //     _to.transfer(amount);
    // }
    // error SendFailed(address sender);
    // function sendETH(address payable _to, uint256 amount) external payable{
    //     bool success = _to.send(amount);
    //     if(!success){
    //         revert SendFailed(msg.sender);
    //     }
    // }
    error CallFailed(address sender);
    function callETH(address payable _to, uint256 amount) external payable{
        (bool success,) = _to.call{value: amount}("");
        if(!success){
            revert CallFailed(msg.sender);
        }
    }
}

