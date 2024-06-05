// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
contract OtherContract{
    uint256 private _x = 0;

    event Log(uint amount, uint gas);

    fallback() external payable { }
    
    function getBalance() view public returns(uint){
        return address(this).balance;
    }

    function setX(uint x) external payable {
        
        _x = x;
        //转入ETH > 0 就释放Log事件
        if(msg.value > 0){
            emit Log(msg.value, gasleft());
        }
    }

    function getX() external view returns(uint x) {
        x = _x;
    }
}

contract CallContract{
    // function callSetX(address _Address,uint x) external {
    //     OtherContract(_Address).setX(x);
    // }

    // function callGetX(OtherContract _Address) external view returns(uint x){
    //     x = _Address.getX();
    // }

    // function callGetX2(address _Address) external view returns(uint x){
    //     //创建合约变量
    //     OtherContract oc = OtherContract(_Address);
    //     x = oc.getX();
    // }

    //传入合约变量，其实底层还是address
    // function callGetX3(OtherContract _Address) external view  returns(uint x){
    //     // OtherContract oc = OtherContract(_Address);//这确实也是创建合约变量了
        
    //     x = _Address.getX();
    // }
    //创建合约变量
    // function callGetX4(address _Address) external view returns(uint x){
    //     //
    //     OtherContract oc = OtherContract(_Address);
    //     // x = OtherContract(_Address).getX();
    //     x = oc.getX();
    // }

    //
    // function callTransfer(address _Address, uint x) external payable {
    //     OtherContract(_Address).setX{value: msg.value}(x);
    // }

    event Response(bool success, bytes data);
    function callSetX(address _addr, uint x) public payable {
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("setX(uint)",x)
        );
        emit Response(success,data);
    }

    function callGetX(address _addr) external returns(uint){
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("getX()")
        );
        emit Response(success, data);
        return abi.decode(data,(uint));
    }
    
    function callNonExit(address _addr) external {
        (bool success, bytes memory data) = _addr.call(
            abi.encodeWithSignature("foo()")
        );
        
        emit Response(success, data);
    }
    
}