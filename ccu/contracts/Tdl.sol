pragma solidity ^0.8.11;
  
contract Tdl{
    string public name ;
    uint public currentTokens ;

    constructor() public{
        name = "Unknown" ;
        currentTokens = 12 ;
    }

    function set(string memory person) public{
        name = person;
    }

    function decrement(uint decrementBy) public{
        currentTokens -= decrementBy ;
    }


    function increment(uint incrementBy) public{
        currentTokens += incrementBy ;
    }

}