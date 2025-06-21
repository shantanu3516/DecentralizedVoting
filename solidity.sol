// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract DecentralizedVoting {
    address public admin;
    bool public votingStarted;
    bool public votingEnded;

    struct Proposal {
        string description;
        uint256 voteCount;
    }

    mapping(address => bool) public hasVoted;
    Proposal[] public proposals;

    constructor() {
        admin = msg.sender;

        // Hardcoded proposals
        proposals.push(Proposal("Proposal A", 0));
        proposals.push(Proposal("Proposal B", 0));
        proposals.push(Proposal("Proposal C", 0));
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    function startVoting() external onlyAdmin {
        require(!votingStarted, "Voting already started");
        votingStarted = true;
    }

    function endVoting() external onlyAdmin {
        require(votingStarted, "Voting hasn't started yet");
        require(!votingEnded, "Voting already ended");
        votingEnded = true;
    }

    function vote(uint256 proposalIndex) external {
        require(votingStarted && !votingEnded, "Voting not active");
        require(!hasVoted[msg.sender], "You have already voted");
        require(proposalIndex < proposals.length, "Invalid proposal");

        proposals[proposalIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getProposals() external view returns (Proposal[] memory) {
        return proposals;
    }

    function getWinningProposal() public view returns (uint256 winningProposalIndex) {
        require(votingEnded, "Voting not yet ended");

        uint256 highestVotes = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > highestVotes) {
                highestVotes = proposals[i].voteCount;
                winningProposalIndex = i;
            }
        }
    }
}
