//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract CrowdFunding{
    mapping(address=>uint) public contributors;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    struct Request{
        string Descripation;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfvoters;
        mapping(address=>bool) voters; 
    }

    mapping( uint => Request) public request;
    uint public numRequests;
    constructor(uint _target, uint _deadline){
        target= _target;
        deadline = block.timestamp+_deadline; //10sec + 3600sec (60*60)
        minimumContribution = 100 wei;
        manager = msg.sender;
    }
    function sendEth() public payable{
        require(block.timestamp < deadline,"Deadline has passed");
        require(msg.value >= minimumContribution,"Minimum Contribution Not Met");

        if(contributors[msg.sender]==0){
            noOfContributors++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;
    }
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    function refund() public{
        require(block.timestamp>deadline && raisedAmount<target, "You are not eligible for refund");
        require(contributors[msg.sender]>0);
        address payable user=payable(msg.sender);
        user.transfer(contributors[msg.sender]);
    }
    modifier onlyManager(){
        require(msg.sender==manager,"only manager call this function");
        _;
    }
    function createRequests(string memory _descripation, address payable _recipient, uint _value) public onlyManager{
        Request storage newRequest = request[numRequests];
        numRequests++;
        newRequest.Descripation = _descripation;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfvoters = 0;
    }
    function voteRequest(uint _requestNo) public {
        require(contributors[msg.sender]>0,'you must be contributor');
        Request storage thisRequest = request[_requestNo];
        require(thisRequest.voters[msg.sender]=false,'you have already voted');
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfvoters++;
    }
    function makePayment(uint _requestNo) public onlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest=request[_requestNo];
        require(thisRequest.completed== false,"the request has been completed");
        require(thisRequest.noOfvoters > noOfContributors/2, "the request needs more votes");
        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;
    }
}