// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {MockV3Aggregator} from "../test/mock/MockV3Aggregator.sol";
import {Script, console2} from "forge-std/Script.sol";

abstract contract CodeConstants {
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8;
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant ETH_HOLESKY_CHAIN_ID = 17000;
    uint256 public constant ZKSYNC_SEPOLIA_CHAIN_ID = 300;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
}

contract HelperConfig is CodeConstants, Script {
    error HelperConfig__InvalidChainId();

    struct NetworkConfig {
        address feedAdress;
    }

    NetworkConfig public anvilConfiguration;
    mapping(uint256 chainId => NetworkConfig) public networkConfiguration;

    constructor() {
        networkConfiguration[ETH_SEPOLIA_CHAIN_ID] = getSepoliaEthConfig();
        networkConfiguration[ETH_HOLESKY_CHAIN_ID] = getHoleskyEthConfig();
        networkConfiguration[
            ZKSYNC_SEPOLIA_CHAIN_ID
        ] = getZkSyncSepoliaConfig();
    }

    function getConfigByChainId(
        uint256 chainId
    ) public returns (NetworkConfig memory) {
        if (networkConfiguration[chainId].feedAdress != address(0)) {
            return networkConfiguration[chainId];
        } else if (chainId == LOCAL_CHAIN_ID) {
            return getOrCreateAnvilEthConfig();
        } else {
            revert HelperConfig__InvalidChainId();
        }
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                feedAdress: 0x694AA1769357215DE4FAC081bf1f309aDC325306
            });
    }

    function getZkSyncSepoliaConfig()
        public
        pure
        returns (NetworkConfig memory)
    {
        return
            NetworkConfig({
                feedAdress: 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
            });
    }

    // this works because eoracle EOFeedAdapter implements the same interface as chainlink
    function getHoleskyEthConfig() public pure returns (NetworkConfig memory) {
        return
            NetworkConfig({
                feedAdress: 0xadE0B2B50939fE630eFc6bF2A2a43D4Aeea482Cc
            });
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        if (anvilConfiguration.feedAdress != address(0)) {
            return anvilConfiguration;
        }
        console2.log(unicode"Mocking 🐦");
        vm.startBroadcast();
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
            DECIMALS,
            INITIAL_PRICE
        );
        vm.stopBroadcast();

        anvilConfiguration = NetworkConfig({
            feedAdress: address(mockPriceFeed)
        });
        return anvilConfiguration;
    }
}