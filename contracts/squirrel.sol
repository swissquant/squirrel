// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import "@squeeth/packages/hardhat/contracts/core/Controller.sol";

contract Squirrel {
    Controller controller;

    function shortPowerPerp() public view returns (address) {
        return controller.shortPowerPerp();
    }
}
