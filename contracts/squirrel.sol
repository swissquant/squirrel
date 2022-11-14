// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

import {VaultLib} from "@squeeth/packages/hardhat/contracts/libs/VaultLib.sol";
import {Controller} from "@squeeth/packages/hardhat/contracts/core/Controller.sol";
import {Power2Base} from "@squeeth/packages/hardhat/contracts/libs/Power2Base.sol";

contract Squirrel {
    // Libraries
    using SafeMath for uint96;
    using SafeMath for uint256;

    // Contract variables
    Controller controller;
    uint256 constant ONE = 1e18;
    uint256 constant ONE_ONE = 1e36;

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

    /*
    Fetch the details of a vault by vaultId
    */
    function getVault(uint256 vaultId) internal view returns (VaultLib.Vault memory) {
        address operator;
        uint32 NftCollateralId;
        uint96 collateralAmount;
        uint128 shortAmount;
        (operator, NftCollateralId, collateralAmount, shortAmount) = controller.vaults(vaultId);

        return VaultLib.Vault(operator, NftCollateralId, collateralAmount, shortAmount);
    }

    /*
    Calculate the maximum amount of squeeth that is possible to mint given the current collateralisation of the vault
    */
    function maxMintPowerPerp(uint256 vaultId) public view returns (uint256) {
        // Fetching the ingredients for the upcoming calculations
        VaultLib.Vault memory vault = getVault(vaultId);
        uint256 normalizationFactor = controller.getExpectedNormalizationFactor();
        uint256 ethPrice = getEthPrice();

        // Calculating the debt of the vault in ETH
        uint256 debtValueInETH = uint256(vault.shortAmount).mul(normalizationFactor).mul(ethPrice).div(ONE_ONE);
        
        // Calculating the amount of squeeth that is possible to mint given the current status of the vault
        uint256 powerPerp = vault.collateralAmount.mul(2).div(ethPrice.mul(normalizationFactor).mul(3)).mul(ONE_ONE) - debtValueInETH;

        return powerPerp;
    }
}
