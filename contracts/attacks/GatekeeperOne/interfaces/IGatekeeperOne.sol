// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGatekeeperOne {
    function entrant() external view returns (address);

    function enter(bytes8 _gateKey) external returns (bool);
}
