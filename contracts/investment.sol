// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.16 <0.9.0;

import './bank.sol';
// allow user to make new account each time when user make an fd
// allow user to automitally recieve money when  time is completed
// handle intrest rating


// Replace the constructor arguments below with the actual arguments required by BankContract's constructor
contract InvestMent is BankContract {
    struct UserFD {
    bytes32 accountid;
    uint Rate;
    uint Time;
    uint principleAmt;
    uint256 startTime; 
    }
    mapping (address => UserFD[]) Fddata;
    constructor(string memory _bankname, string memory _email, uint32 _phone) 
        BankContract(_bankname, _email)
    {}
    function OpenFDAccount(uint _principleamt) public {
        
    }
    
}