contract DEX {
    
    IERC20 public token;

    event Bought(uint256 amount);
    event Sold(uint256 amount);

    constructor() public {
        token = new ERC20Basic();
    }

    function buy() payable public {
        uint256 amountToBuy = msg.value; // amount of Eth sent to this contract
        uint256 dexBalance = token.balanceOf(address(this)); // amount of token in this contract
        require(amountToBuy > 0, "You need some Ether"); 
        require(amountToBuy <= dexBalance, "Not enough tokens in the reserve");
        token.transfer(msg.sender, amountToBuy); // token transfer to buyer
        emit Bought(amountToBuy);
    }

    function sell(uint256 amount) public {
        require(amount > 0, "You need to sell at least some tokens");
        uint256 allowance = token.allowance(msg.sender, address(this)); // how much this contract can spend on behalf of the seller
        require(allowance >= amount, "Check the token allowance");
        token.transferFrom(msg.sender, address(this), amount); // send the seller's tokens to this contract
        msg.sender.transfer(amount); // send Eth to seller
        emit Sold(amount);
    } 
}
