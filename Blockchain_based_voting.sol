pragma solidity ^0.8.0;

contract Voting {
    mapping(address => bool) public hasVoted;
    mapping(uint256 => uint256) public votesCount;
    address public admin;

    event Voted(address indexed voter, uint256 candidate);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function vote(uint256 _candidate) public {
        require(!hasVoted[msg.sender], "You have already voted");
        votesCount[_candidate]++;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, _candidate);
    }

    function getVoteCount(uint256 _candidate) public view returns (uint256) {
        return votesCount[_candidate];
    }

    function changeAdmin(address _newAdmin) public onlyAdmin {
        admin = _newAdmin;
    }
}