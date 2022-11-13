// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import "@squeeth/packages/hardhat/contracts/core/Controller.sol";

contract Squirrel {
    Controller controller = Controller(0x50f3D0826d4E3c3d49007DBa664727B9885Dd734);

    function shortPowerPerp() public view returns (address) {
        return controller.shortPowerPerp();
    }
}
