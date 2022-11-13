// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

// import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
// import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@squeeth/packages/hardhat/contracts/core/Controller.sol";

contract Squirrel {
    Controller controller;

    function shortPowerPerp() public returns (address) {
        return controller.shortPowerPerp();
    }
}
