pragma solidity >=0.4.21;

contract MyPayVendorContract {
    
    uint256 public vendCounter = 0;
    address public issuer;
    uint public issuerBal;
    
    event Sent(address from, address to, string name, uint amount);
    
     struct Vendor {
        uint256 _cid;
        string _name;
        address _addr;
        uint256 _owedAmount;
    }
    
    mapping(uint => Vendor) public vendors;
    mapping (address => uint) public balance;
    
    constructor() public {
        issuer = msg.sender;
    } 
    
    
    function addVendor(string memory _name, address _addr, uint256 _owedAmount) public {
       vendors[vendCounter] = Vendor(vendCounter, _name, _addr, _owedAmount);
       vendCounter++;
    }
    
    function issue (address receiver, uint amount) public {
        require(msg.sender == issuer);
        require(amount < 1000);
        issuerBal += amount;  
        balance[receiver] += amount;
    }
    
    function send() public {
        uint256 j;   
        for (j = 0; j< vendCounter; j++ ){
            address receiver = vendors[j]._addr;
            uint256 amount = vendors[j]._owedAmount;
            string memory vname = vendors[j]._name;
            require(amount <= balance[msg.sender], "Invalid number of assets.");
            balance[msg.sender] -= amount;
            balance[receiver] += amount;
            emit Sent(msg.sender, receiver, vname, amount);
            issuerBal = issuerBal - amount;    
        }        
    }

}