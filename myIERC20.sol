//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

interface IERC20 {
    
    // --- GETTERS ---

    // Returns the amount of tokens in existance
    // Remember: there are no floats in Solidity!
    function totalSupply() external view returns (uint); 

    // Returns the amount of tokens owned by an address
    function balanceOf(address account) external view returns (uint256); 

    // The ERC20 standard allows to give permission to another address to retrieve the tokens from it. 
    // Returns the remaining numbers of token the spender can spend on behalf of owner
    function allowance(address owner, address spender) external view returns (uint256); 
                                                                                        
    // --- FUNCTIONS ---

    // Transfers the token from msg.sender to the recipient address.
    // Returns true if the transfer is possible
    function transfer(address recipient, uint256 amount) external returns (bool); 
                                                                                  
    // Set the amount of allowance
    function approve(address spender, uint256 amout) external view returns (bool); 

    // Moves the amount of tokens from sender to recipient using the allowance mechanism
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool)

    // --- EVENTS ---
    
    // Event emitted when the amount is sent from the from address to the to address
    // In the case of minting new tokens the from is 0x0 and in the case of burning the to is 0x0
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Event emitted when the amount of tokens is approved by the owner to be used by the spender
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract ERC20Basic is IERC20 {
    
    string public constant name = "ERC20Basic";
    string public constant symbol = "ERC";
    uint8 public constant decimals = 18;

    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowed;

    uint256 totalSupply_;

    using SafeMath for uint256;

    constructor(uint256 total) public {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        returns totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance(address owner, address delegate) public override view returns (uint) {
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender]);

        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner, buyer, numTokens);
    }
}


library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a-b;
    }

    function add(uint256 a, uint265 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
