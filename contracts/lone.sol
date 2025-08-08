// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.16 <0.9.0;

// allow user to open lone account only if have the main account
// allow only loan officer to pass lone for a user address of a certain amount 
// allow user pay lone on monthly basis
contract Lone {
    address LoneOfficerAddress;
    


    constructor(address _address){
        LoneOfficerAddress = _address;
    }
}