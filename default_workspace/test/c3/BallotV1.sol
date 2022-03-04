// SPDX-License-Identifier: MIT License
// pragma solidity >=0.4.2 =<0.6.0;
// pragma solidity ^0.7.2;
pragma solidity ^0.8.7;
contract BallotV1{
	struct Voter {
		uint weight;
		bool voted;
		uint vote;
	}

	struct Proposal {
		uint voteCount;
	}

	address chairperson;
	mapping(address => Voter) voters;
	Proposal[] proposals;
	enum Phase {
		Init, 
		Regs, 
		Vote, 
		Done
	}
	Phase public state = Phase.Init;

	modifier validPhase(Phase reqPhase){
		require ( state == reqPhase);
		_;
	}

	// abstract
	//Visibility for constructor is ignored. If you want the contract to be non-deployable, making it "abstract" is sufficient. public를 지우라네 
	// constructor (uint numProposals) public {
	constructor (uint8 numProposals) {
		// chairperson = msg.sender;
		// voters[chairperson].weight = 2;
		// for (uint prop = 0; prop < numProposals; prop ++){
		// 	proposals.push(Proposal(0));
		// }
	}
	function changeState (Phase x) public {
		if(msg.sender != chairperson) revert();
		if(x<state) revert();
		state = x;
	}

	function register(address voter) public validPhase(Phase.Regs){
		if(msg.sender != chairperson ||  voters[voter].voted) return;
		voters[voter].weight = 1;
		voters[voter].voted = false;
	}

	function vote(uint toProposal) public validPhase(Phase.Vote){
		Voter memory sender = voters[msg.sender];
		if(sender.voted ||
			toProposal >= proposals.length) revert();
		sender.voted = true;
		sender.vote = toProposal;
		proposals[toProposal].voteCount += sender.weight;
	}

	function reqWinner() public validPhase(Phase.Done) view returns(uint winningProposal){
		uint winningVoteCount = 0;
		for (uint prop = 0; prop < proposals.length; prop++){
			if(proposals[prop].voteCount > winningVoteCount){
				winningVoteCount = proposals[prop].voteCount;
				winningProposal = prop;
			}
		}
	}
}