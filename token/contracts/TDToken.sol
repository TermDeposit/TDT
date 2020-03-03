// pragma solidity ^0.4.18;
pragma solidity >=0.4.21 <0.7.0;

library SafeMath { // Only relevant functions
    function sub(uint256 a, uint256 b) internal pure returns (uint256) 
    {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256)   
    {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}



contract TDToken {

    using SafeMath for uint256;

    // De-Facto fields
    string public constant name = 'Term Deposit Token';
    string public constant symbol = 'TDT';
    uint8 public constant decimals = 18;

    // 2 basic events
    event Approval(address indexed tokenMalik, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);

    // An Associative Key/Value Array where address are keys and uint256 are 256-bit integer
    mapping(address => uint256) balances; // Balances will hold balances of token owner
    mapping(address => mapping (address => uint256)) allowed; // Account allowed to withdraw from account

    uint256 totalSupply_;
    
    // Constructor called when contract deployed
    constructor(uint256 total) public {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    // Get Balance of Address
    function balanceOf(address tokenMalik) public view returns (uint256) {
        return balances[tokenMalik];
    }


    // Transfer token
    function transfer(address receiver, uint256 numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    // Approve Delegate Account for specific number of tokens
    function approve(address delegate, uint256 numTokens) public returns (bool){
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    // Get Tokens Approved for Withdrawal
    function allowance(address malik, address delegate) public view returns (uint256) {
        return allowed[malik][delegate];
    }

    // Allows Delegate to transfer to third party
    function transferFrom(address malik, address buyer, uint numTokens) public returns (bool){
        require(numTokens <= balances[malik]);
        require(numTokens <= allowed[malik][msg.sender]);
        balances[malik] = balances[malik].sub(numTokens);
        allowed[malik][msg.sender] = allowed[malik][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(malik, buyer, numTokens);
        return true;
    }

}