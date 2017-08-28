//Deployed @ 0x6F91b454b32e92476900c08e3B095d2B6cFC6f50 in Ropsten
pragma solidity ^0.4.0;

contract Ballot {
    struct Vote {
        bool eligible;
        bool cast;
    }
    
    event VoteCast(
        uint8 _candidate,
        uint voteCount
    );
    address operator;
    mapping(address => Vote) votes;
    uint[] voteCount;
    
    function Ballot(uint8 _numCandidates) {
        voteCount.length = _numCandidates;
        operator = msg.sender;
    }
    
    function getVotes() constant returns (uint[]) {
        return voteCount;
    }
    
    function getCandidateCount() constant returns (uint8) {
        return uint8(voteCount.length);
    }
    
    function givePermission(address voter) {
        require(msg.sender == operator); 
        require(!votes[voter].cast); //should not have voted
        votes[voter].eligible = true;
        votes[voter].cast = false;
    }
    function vote(uint8 candidate){
        require(votes[msg.sender].eligible && !votes[msg.sender].cast);
        voteCount[candidate]++;
        votes[msg.sender].cast = true;
        VoteCast(candidate, voteCount[candidate]);
    }
    
}