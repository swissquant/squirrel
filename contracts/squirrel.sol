// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import {VaultLib} from "@squeeth/packages/hardhat/contracts/libs/VaultLib.sol";
import {Controller} from "@squeeth/packages/hardhat/contracts/core/Controller.sol";
import {Power2Base} from "@squeeth/packages/hardhat/contracts/libs/Power2Base.sol";

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

contract Squirrel {
    // Libraries
    using SafeMath for uint256;

    // Contract variables
    Controller controller;
    uint256 constant ONE_ONE = 1e36;
    mapping(uint256 => VaultLib.Vault) public vaults;

    // Constructor
    constructor(
        address payable _controllerAddress
    ) {
        controller = Controller(_controllerAddress);
    }

    /*
    Returns the twapped ETH price
    */
    function getEthPrice() public view returns (uint256) {
        uint256 _scaledEthPrice = Power2Base._getScaledTwap(
            controller.oracle(),
            controller.ethQuoteCurrencyPool(),
            controller.weth(),
            controller.quoteCurrency(),
            controller.TWAP_PERIOD(),
            true
        );

        return _scaledEthPrice;
    }

    // In construction
    function maxMintPowerPerp(uint256 vaultId) public view returns (uint256) {
        VaultLib.Vault memory vault = vaults[vaultId];
        uint256 normalizationFactor = controller.getExpectedNormalizationFactor();
        uint256 ethQuoteCurrencyPrice = 0;
        uint256 debtValueInETH = uint256(vault.shortAmount).mul(normalizationFactor).mul(ethQuoteCurrencyPrice).div(ONE_ONE);

        return normalizationFactor;
    }

    function shortPowerPerp() public view returns (address) {
        return controller.shortPowerPerp();
    }
}
