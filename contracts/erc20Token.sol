pragma solidity ^0.5.16;

import "./erc20Interface.sol";

contract ERC20Token is ERC20Interface {
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

    uint256 public toSupply; //Total number of tokens
    string public name; // Descriptive name 
    uint8 public decimals; //How many decimals to use when displaying amts
    string public symbol; //Short identifier for token i.e. FDT

    //Create the new token and assign initial values, including initial amt
    constructor( 
        uint256 _initialAmount, 
        string memory _tokenName, 
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) public {
        balances[msg.sender] = _initialAmount; // The creator owns all initial tokens
        totSupply = _initialAmount; //UPdate total token suppply
        name = _tokenName; //Store the token name
        decimals = _decimalUnits; //Store the number of the decimals, used for the display only
        symbol = _tokenSymbol; //Store the token symbol, used for display only
    }

    //Transfer tokens from msg.sender to a specified address
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value,"Insufficient funds for transfer source.");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    //Transfer tokens from one specified address to another specified address
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value, "Insufficient allowed funds for transfer");
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value); 
        return true;
    }

    //Return the current balance (in tokens) of a specified address 
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    //set 
    function approve(address _sender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _sender, _value);
        return true;
    }

    //Return the 
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
    return allowed[_owner][_spender];
    }   

    //Return the total number of tokens in circulation 
    function totalSupply() public view returns (uint256 totSupp) {
        return totSupply;
    }
    }