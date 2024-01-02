class MockApiKiraGovernanceProposals {
  static Map<String, dynamic> defaultResponse = {
    "pagination": {"next_key": "", "total": "7"},
    "proposals": [
      {
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
      {
        "content": {
          "@type": "/kira.tokens.ProposalUpsertTokenAlias",
          "decimals": 8,
          "denoms": ["test"],
          "icon": "http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/test.svg",
          "invalidated": false,
          "name": "Test TestCoin",
          "symbol": "TEST"
        },
        "description": "Initial Setup From KIRA Manager",
        "enactment_end_time": "2023-05-25T13:12:11.907569920Z",
        "exec_result": "executed successfully",
        "min_enactment_end_block_height": "60",
        "min_voting_end_block_height": "27",
        "proposal_id": "2",
        "result": "VOTE_RESULT_PASSED",
        "submit_time": "2023-05-25T13:01:11.907569920Z",
        "title": "Upsert Test TestCoin icon URL link",
        "voting_end_time": "2023-05-25T13:07:11.907569920Z"
      },
      {
        "content": {
          "@type": "/kira.upgrade.ProposalSoftwareUpgrade",
          "instateUpgrade": true,
          "maxEnrolmentDuration": "666",
          "memo": "Genesis Setup Plan",
          "name": "genesis",
          "newChainId": "localnet-4",
          "oldChainId": "localnet-4",
          "rebootRequired": true,
          "resources": [
            {"checksum": "", "id": "kira", "url": "https://github.com/KiraCore/kira/releases/download/v0.11.21/kira.zip", "version": ""}
          ],
          "rollbackChecksum": "genesis",
          "skipHandler": true,
          "upgradeTime": "1685020552"
        },
        "description": "",
        "enactment_end_time": "2023-05-25T13:12:51.939112371Z",
        "exec_result": "executed successfully",
        "min_enactment_end_block_height": "64",
        "min_voting_end_block_height": "31",
        "proposal_id": "4",
        "result": "VOTE_RESULT_PASSED",
        "submit_time": "2023-05-25T13:01:51.939112371Z",
        "title": "",
        "voting_end_time": "2023-05-25T13:07:51.939112371Z"
      },
    ]
  };
}
