class MockApiKiraGovernanceProposal {
  static Map<String, dynamic> defaultResponse = {
    "proposal": {
      "content": {
        "@type": "/kira.tokens.ProposalUpsertTokenAlias",
        "decimals": 6,
        "denoms": ["ukex"],
        "icon": "http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg",
        "invalidated": false,
        "name": "KIRA",
        "symbol": "KEX"
      },
      "description": "Initial Setup From KIRA Manager",
      "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
      "exec_result": "executed successfully",
      "min_enactment_end_block_height": "58",
      "min_voting_end_block_height": "25",
      "proposal_id": "1",
      "result": "VOTE_RESULT_PASSED",
      "submit_time": "2023-05-25T13:00:51.893680415Z",
      "title": "Upsert KEX icon URL link",
      "voting_end_time": "2023-05-25T13:06:51.893680415Z"
    },
    "votes": [
      {"option": "VOTE_OPTION_YES", "proposal_id": "1", "slash": "10000000000000000", "voter": "ZtzUOqrXZFSaMUg5Da0aHqhCcxs="}
    ]
  };
}
