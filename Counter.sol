//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

abstract contract Counter {

    event ValueChanged(uint newValue);
    
    // Public variable of type unsigned int to keep the number of counts
    uint256 private count = 0;

    constructor(uint startValue) {
        count = startValue;
    }

    function setCounter(uint value) internal{
        count = value;
        emit ValueChanged(count);
    }

    // Function that increments our counter
    function increment() public {
        count += 1;
        emit ValueChanged(count);
    }
    
    // Not necessary getter to get the count value
    function step() public virtual;

}