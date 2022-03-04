pragma solidity >=0.4.2 =<0.6.0;
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
	proposal[] proposals;
	enum Phase {
		Init, 
		Regs, 
		Vote, 
		Done
	}
	Phase public state = Phase.Init;
}