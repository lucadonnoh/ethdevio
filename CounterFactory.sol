pragma solidity 0.5.17;

contract Counter {

    uint256 private _count;
    address private _owner;
    address private _factory;

    modifier onlyOwner(address caller) {
        require(caller == _owner, "You're not the owner of the contract");
        _;
    }

    modifier onlyFactor() {
        require(msg.sender == _factory, "You need to use the factory");
        _;
    }

    // It's important to pass the owner because if you call this from another contract, the msg.sender will be the contract address
    constructor(address owner) public {
        _owner = owner;
        _factory = msg.sender;
    }

    function getCount() public view returns (uint256) {
        return _count;
    }

    function increment(address caller) public onlyFactory onlyOwner(caller) {
        _count++;
    }
}

contract CounterFactory {

    mapping(address => Counter) _counters;

    function createCounter() public {
        require(_counters[msg.sender] == Counter(0)); // Requires that the person doesn't already have a Counter
        _counters[msg.sender] = new Counter(msg.sender);
    }

    function getCount(address account) public view returns (uint256) {
        require(_counters[account] != Counter(0));
        return (_counters[account].getCount());
    }

    function getMyCount() public view returns (uint256) {
        return (getCount(msg.sender));
    }

    function increment() public {
        require(_counters[msg.sender] != Counter(0));
        Counter(_counters[msg.sender]).increment(msg.sender);
    }
}
