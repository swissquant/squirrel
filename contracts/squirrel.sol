// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import {VaultLib} from "@squeeth/packages/hardhat/contracts/libs/VaultLib.sol";
import {Controller} from "@squeeth/packages/hardhat/contracts/core/Controller.sol";
import {Power2Base} from "@squeeth/packages/hardhat/contracts/libs/Power2Base.sol";

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";

contract Squirrel {
    using SafeMath for uint256;

    uint256 constant ONE_ONE = 1e36;

    address public immutable oracle = 0x65D66c76447ccB45dAf1e8044e918fA786A483A1;
    address public immutable ethQuoteCurrencyPool = 0x8ad599c3A0ff1De082011EFDDc58f1908eb6e6D8;
    address public immutable weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public immutable quoteCurrency = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    uint32 public constant TWAP_PERIOD = 420 seconds;

    Controller controller = Controller(0x50f3D0826d4E3c3d49007DBa664727B9885Dd734);
    mapping(uint256 => VaultLib.Vault) public vaults;

    function scaledEthPrice() public view returns (uint256) {
        uint256 _scaledEthPrice = Power2Base._getScaledTwap(
            oracle,
            ethQuoteCurrencyPool,
            weth,
            quoteCurrency,
            TWAP_PERIOD,
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
