// SPDX-License-Identifier: UNLICENSED

// /*
pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";

// Attack contract address: "0xc667cC8CEAb81F2B8323028b638B731759e6525f"

interface IAttack {
    function enterGate() external;
}

contract TriggerAttack is Script {
    IAttack public attack;
    address attackAddr = 0xc667cC8CEAb81F2B8323028b638B731759e6525f;

    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        // address account = vm.addr(privateKey);

        vm.startBroadcast(privateKey);
        attack = IAttack(attackAddr);
        vm.stopBroadcast();

        vm.startBroadcast(privateKey);
        attack.enterGate();
        vm.stopBroadcast();
    }
}

// forge script script/TriggerAttack.s.sol:TriggerAttack --rpc-url $SEPOLIA_RPC_URL --broadcast -vvvv
