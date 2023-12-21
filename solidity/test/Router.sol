// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";
import {Router} from "../src/Router.sol";

contract RouterTest is Test {
    Router public router;
    SimpleStorage public _storage;

    function setUp() public {
        _storage = new SimpleStorage();
        router = new Router();
        router.loadFunc(bytes4(keccak256("setValue(uint256)")), address(_storage));
        router.loadFunc(bytes4(keccak256("getValue()")), address(_storage));
    }

    function test() public {
        uint256 value = 100;
        
        bytes memory callData = abi.encodeWithSelector(bytes4(keccak256("setValue(uint256)")), value);
        (bool success, ) = address(router).call{value: 0}(callData);
        assertEq(success, true);

        bytes memory callData2 = abi.encodeWithSelector(bytes4(keccak256("getValue()")));
        (,bytes memory returnedData) = address(router).call{value: 0}(callData2);
        uint256 value2 = abi.decode(returnedData, (uint256));
        assertEq(value2, value);

        router.loadFunc(bytes4(keccak256("div(uint256)")), address(_storage));

        bytes memory callData3 = abi.encodeWithSelector(bytes4(keccak256("div(uint256)")), 2);
        (,bytes memory returnedData1) = address(router).call{value: 0}(callData3);
        uint256 value3 = abi.decode(returnedData1, (uint256));
        assertEq(value3, value / 2);
    }
}