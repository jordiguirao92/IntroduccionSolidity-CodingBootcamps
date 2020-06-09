pragma solidity >=0.4.21;

contract mySendReceiveEther {
    
   mapping(address => uint256 ) public balance;
   address payable mywallet1;
   
   event Purchase (address _buyer, uint256 _amount);
    
   constructor (address payable _wallet) public {
        mywallet1 = _wallet;
        
    }
    
   function buyAsset() public payable{
        balance[msg.sender] += 1;
        mywallet1.transfer(msg.value);
        emit Purchase(msg.sender, 1);
    }

}