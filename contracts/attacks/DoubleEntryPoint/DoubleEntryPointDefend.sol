// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./interfaces/IDoubleEntryPoint.sol";

contract DoubleEntryPointDefend is IDetectionBot {
    IDoubleEntryPoint private immutable target;

    constructor(IDoubleEntryPoint target_) {
        target = target_;
    }

    /**
    * @dev To set the detection bot, you can run this script in client side:
        await web3.eth.sendTransaction({
            to: await contract.forta(),
            from: player,
            data: web3.eth.abi.encodeFunctionCall(
                {
                name: 'setDetectionBot',
                type: 'function',
                inputs: [
                    {
                    type: 'address',
                    name: 'detectionBotAddress'
                    }
                ]
                },
                [<DETECTION_BOT_CONTRACT_ADDRESS>]
            )
        });
    */
    function handleTransaction(address user, bytes calldata msgData) external override {
        IForta forta = target.forta();

        require(msg.sender == address(forta), "DoubleEntryPoint: Unauthorized");

        if (bytes4(abi.encodeWithSelector(target.delegateTransfer.selector)) == bytes4(msgData)) {
            forta.raiseAlert(user);
        }
    }
}
