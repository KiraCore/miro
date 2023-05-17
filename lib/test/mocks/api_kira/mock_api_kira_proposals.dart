class MockApiKiraProposals {
  static Map<String, dynamic> defaultResponse = {
    "total_count": 18,
    "proposals": [
      {
        "proposal_id": "1",
        "title": "Upsert Test TestCoin icon URL link",
        "description": "Initial Setup From KIRA Manager",
        "content": {
          "@type": "/kira.gov.UpsertDataRegistryProposal",
          "encoding": "8",
          "hash": "test",
          "key": "123",
          "reference": "321",
          "size": "100",
        },
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "transaction_hash": "unknown",
        "submit_time": "2023-05-25T13:01:11.907569920Z",
        "voting_end_time": "2023-10-13T13:07:11.907569920Z",
        "enactment_end_time": "2023-05-25T13:12:11.907569920Z",
        "min_voting_end_block_height": "27",
        "min_enactment_end_block_height": "60",
        "exec_result": "executed successfully",
        "result": "VOTE_RESULT_PENDING",
        "voters_count": 1,
        "votes_count": 0,
        "quorum": "0.33",
        "meta_data": "When mainnet?"
      },
      {
        "proposal_id": "2",
        "content": {
          "@type": "/kira.gov.SetNetworkPropertyProposal",
          "networkProperty": "MIN_TX_FEE",
          "value": {"strValue": "", "value": "99"}
        },
        "description": "description",
        "transaction_hash": "0xfa84815a206b6d7adabe773af9d19ed21a4cfa21",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "exec_result": "executed successfully",
        "meta_data": "REF#544561324645465",
        "min_voting_end_block_height": "9",
        "min_enactment_end_block_height": "10",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_PENDING",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Set Network Property to X",
        "voters_count": 32,
        "votes_count": 50,
        "voting_end_time": "2023-10-16T13:06:51.893680415Z"
      },
      {
        "proposal_id": "3",
        "content": {
          "@type": "/kira.gov.CreateRoleProposal",
          "blacklistedPermissions": ["PERMISSION_CREATE_CREATE_ROLE_PROPOSAL", "PERMISSION_VOTE_CREATE_ROLE_PROPOSAL"],
          "roleDescription": "Bruh'(3) role",
          "roleSid": "bruh3",
          "whitelistedPermissions": ["PERMISSION_CREATE_UNJAIL_VALIDATOR_PROPOSAL", "PERMISSION_VOTE_UNJAIL_VALIDATOR_PROPOSAL"]
        },
        "description": "description",
        "transaction_hash": "0xb136376b24310133032e667b75dece9e06105265",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "11",
        "min_enactment_end_block_height": "12",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_QUORUM_NOT_REACHED",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Need new Role for Governing Validators",
        "voters_count": 49,
        "votes_count": 50,
        "voting_end_time": "2023-10-17T13:06:51.893680415Z"
      },
      {
        "proposal_id": "4",
        "content": {"@type": "/kira.gov.BlacklistRolePermissionProposal", "permission": "PERMISSION_VOTE_UPSERT_DATA_REGISTRY_PROPOSAL", "roleIdentifier": "3"},
        "description": "description",
        "transaction_hash": "0xb136376b24310133032e667b75dece9e06105265",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "exec_result": "executed successfully",
        "meta_data": "REF#544561324645465",
        "min_voting_end_block_height": "13",
        "min_enactment_end_block_height": "14",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_ENACTMENT",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Blacklist Role Permission",
        "voters_count": 31,
        "votes_count": 50,
        "voting_end_time": "2023-10-18T13:06:51.893680415Z"
      },
      {
        "proposal_id": "5",
        "content": {"@type": "/kira.gov.AssignRoleToAccountProposal", "address": "93IDMt+KI+CnCHWAZlhz1GSfySw=", "roleIdentifier": "4"},
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PASSED_WITH_EXEC_FAIL",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Assigning Role to Validator example",
        "voters_count": 29,
        "votes_count": 50,
        "voting_end_time": "2023-10-19T13:06:51.893680415Z"
      },
      {
        "proposal_id": "6",
        "content": {
          "@type": "/kira.gov.RemoveBlacklistedRolePermissionProposal",
          "permission": "PERMISSION_CREATE_UPSERT_DATA_REGISTRY_PROPOSAL",
          "roleSid": "bruh"
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_UNKNOWN",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Remove Blacklisted Role Permissions",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-20T13:06:59.893680415Z"
      },
      {
        "proposal_id": "7",
        "content": {"@type": "/kira.gov.WhitelistRolePermissionProposal", "permission": "PERMISSION_VOTE_UPSERT_DATA_REGISTRY_PROPOSAL", "roleIdentifier": "3"},
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PASSED_WITH_EXEC_FAIL",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "WhiteList Role Permissions",
        "voters_count": 39,
        "votes_count": 50,
        "voting_end_time": "2023-10-21T13:06:60.893680415Z"
      },
      {
        "proposal_id": "8",
        "content": {
          "@type": "/kira.gov.SetPoorNetworkMessagesProposal",
          "messages": ["xxx.yyy"]
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PASSED",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Upgrade Poor Network Message",
        "voters_count": 45,
        "votes_count": 50,
        "voting_end_time": "2023-10-22T13:06:61.893680415Z"
      },
      {
        "proposal_id": "9",
        "content": {"@type": "/kira.gov.ProposalResetWholeCouncilorRank", "description": "", "proposer": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09"},
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PENDING",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Reset a Councilor from their rank",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-23T13:06:61.893680415Z"
      },
      {
        "proposal_id": "10",
        "content": {
          "@type": "/kira.gov.SetProposalDurationsProposal",
          "proposalDurations": ["100"],
          "typeofProposals": ["100"],
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PASSED_WITH_EXEC_FAIL",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Set proposal Duration",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-24T13:06:61.893680415Z"
      },
      {
        "proposal_id": "11",
        "content": {
          "@type": "/kira.gov.SOME-CUSTOM-UNKNOWN-TYPE",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_REJECTED_WITH_VETO",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Some custom proposal",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-25T13:06:61.893680415Z"
      },
      {
        "proposal_id": "12",
        "content": {
          "@type": "/kira.gov.BlacklistAccountPermissionProposal",
          "address": "12254879988765",
          "permission": "yes",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_REJECTED",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Blacklist Account Permission",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-26T13:06:61.893680415Z"
      },
      {
        "proposal_id": "13",
        "content": {
          "@type": "/kira.gov.RemoveBlacklistedAccountPermissionProposal",
          "address": "12254879988765",
          "permission": "yes",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_QUORUM_NOT_REACHED",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Remove Blacklisted Account Permission",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-27T13:06:61.893680415Z"
      },
      {
        "proposal_id": "14",
        "content": {
          "@type": "/kira.gov.RemoveWhitelistedAccountPermissionProposal",
          "address": "12254879988765",
          "permission": "yes",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_PENDING",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Remove Whitelisted Account Permission",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-28T13:06:61.893680415Z"
      },
      {
        "proposal_id": "15",
        "content": {
          "@type": "/kira.gov.RemoveWhitelistedRolePermissionProposal",
          "permission": "yes",
          "roleSid": "12254879988765",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PASSED_WITH_EXEC_FAIL",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Remove Whitelisted Role Permission",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-29T13:06:61.893680415Z"
      },
      {
        "proposal_id": "16",
        "content": {
          "@type": "/kira.gov.UnassignRoleFromAccountProposal",
          "address": "yes",
          "roleIdentifier": "12254879988765",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_PASSED",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Unassign Role From Account",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-30T13:06:61.893680415Z"
      },
      {
        "proposal_id": "17",
        "content": {
          "@type": "/kira.gov.WhitelistAccountPermissionProposal",
          "permission": "yes",
          "address": "12254879988765",
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_ENACTMENT",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Whitelist Account Permission",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-31T13:06:61.893680415Z"
      },
      {
        "proposal_id": "18",
        "content": {
          "@type": "/kira.gov.MsgVoteProposal",
          "proposal_id": "13",
          "voter": "kira1vmwdgw426aj9fx33fqusmtg6r65yyucmx6rdt4",
          "option": "VOTE_OPTION_YES",
          "slash": "0.010000000000000000"
        },
        "description": "description",
        "transaction_hash": "0xf2cdd6c4e17e640fc1a2e833ef534c554f661548",
        "enactment_end_time": "2023-05-25T13:11:51.893680415Z",
        "meta_data": "REF#544561324645465",
        "exec_result": "executed successfully",
        "min_voting_end_block_height": "15",
        "min_enactment_end_block_height": "16",
        "proposer_info": {
          "moniker": "VaMIROdator",
          "address": "kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09",
          "logo": "https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png"
        },
        "quorum": "33%",
        "result": "VOTE_RESULT_ENACTMENT",
        "submit_time": "2023-05-25T13:00:51.893680415Z",
        "title": "Whitelist Account Permission",
        "voters_count": 35,
        "votes_count": 50,
        "voting_end_time": "2023-10-31T13:06:61.893680415Z"
      }
    ]
  };
}
