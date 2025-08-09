// SPDX-License-Identifier: MIT 
pragma solidity >=0.4.16 <0.9.0;


// action to be perform

// open account
// deposit
// withdraw
// transfer payment
// view balance

// account for investment fd
    // intrest rate , time 
    // i = p*r*t/100
    // amount = i + p
    
// one account cration for lone borowing and paying
    // declare amount to be borowed
    // rate of intrest for paying long in t time



contract BankContract{
    address public owner;
    string public BankName;
    string email;
    uint public countUser = 0;
    uint public Timeofinitialization;
    
    struct UserDetails{
        string name;
        uint16 age ;
        uint32 phonenum;
        string email;
        uint createdAt;
        bool IsActive;
        bool HasLoneAccount;
        bool HasInvestMentAccount;
        uint numberofaccount;
    }
    enum UpdateType { None, Deposit, Withdraw, Transfer, Revieved }
    struct Balance{
        uint amount;
        uint LastUpdate;
        UpdateType lastAction;
        uint LastExpenditure;
    }
    mapping (address => UserDetails) public users;
    mapping (address => Balance) balance;
    event BankOpened(address to, string message);
    constructor(string memory _bankname,string memory _email){
        owner = msg.sender;
        BankName = _bankname;
        email  = _email;
        Timeofinitialization = block.timestamp;
        emit BankOpened(msg.sender,"Bank Opened");
    }
    // count the number of users
    function NumberOfAccounts() public view returns(uint){
        return countUser;
    }
    // create user
    function CreateSuperAccount(
        string memory _name,
        uint16 _age,
        uint32 _phonenum,
        string memory _email
    ) public {
        require(!IsAccountExist(msg.sender), "Account already exists");
        users[msg.sender] = UserDetails({
            name: _name,
            age: _age,
            phonenum: _phonenum,
            email: _email,
            createdAt: block.timestamp,
            IsActive:true,
            HasLoneAccount:false,
            HasInvestMentAccount:false,
            numberofaccount : 1
        });
        countUser++;
    }
    // check if user exist
    function IsAccountExist(address ad) public view returns(bool){
        return users[ad].IsActive;
    }
    // deposit
    function Deposit(uint _amount) public {
        require(IsAccountExist(msg.sender), "Account does not exist");
        balance[msg.sender].amount += _amount;
        balance[msg.sender].LastUpdate = block.timestamp;
        balance[msg.sender].LastExpenditure = _amount;
        balance[msg.sender].lastAction = UpdateType.Deposit;
    }
    // withdraw
    function WithDraw(uint _amount) public {
        require(IsAccountExist(msg.sender), "Account does not exist");
        balance[msg.sender].amount -= _amount;
        balance[msg.sender].LastUpdate = block.timestamp;
        balance[msg.sender].LastExpenditure = _amount;
        balance[msg.sender].lastAction = UpdateType.Withdraw;
    }
    // transfer
    function Transfer(address _to, uint _amount) public {
        require(IsAccountExist(msg.sender), "Sender account does not exist");
        require(IsAccountExist(_to), "Receiver account does not exist");
        require(balance[msg.sender].amount >= _amount, "Insufficient balance");
        // Subtract from sender
        balance[msg.sender].amount -= _amount;
        balance[msg.sender].LastUpdate = block.timestamp;
        balance[msg.sender].LastExpenditure = _amount;
        balance[msg.sender].lastAction = UpdateType.Transfer;
        // Add to receiver
        balance[_to].amount += _amount;
        balance[_to].LastUpdate = block.timestamp;
        balance[_to].lastAction = UpdateType.Revieved; // or you could use a new enum like `UpdateType.Received`
    }
    // view
    function getMyAccountInfo() public view returns (UserDetails memory, Balance memory) {
        require(users[msg.sender].IsActive, "Account does not exist");
        return (users[msg.sender], balance[msg.sender]);
    }
}