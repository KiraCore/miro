class MockApiGenesis {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "genesis_time": "2023-11-28T08:58:23.787083017Z",
    "chain_id": "localnet-1",
    "initial_height": "1",
    "consensus_params": {
      "block": {"max_bytes": "22020096", "max_gas": "-1"},
      "evidence": {"max_age_num_blocks": "100000", "max_age_duration": "172800000000000", "max_bytes": "1048576"},
      "validator": {
        "pub_key_types": ["ed25519"]
      },
      "version": {"app": "0"}
    },
    "app_hash": "",
    "app_state": {
      "auth": {
        "params": {
          "max_memo_characters": "256",
          "tx_sig_limit": "7",
          "tx_size_cost_per_byte": "10",
          "sig_verify_cost_ed25519": "590",
          "sig_verify_cost_secp256k1": "1000"
        },
        "accounts": [
          {
            "@type": "/cosmos.auth.v1beta1.BaseAccount",
            "address": "kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457",
            "pub_key": null,
            "account_number": "0",
            "sequence": "0"
          },
          {
            "@type": "/cosmos.auth.v1beta1.BaseAccount",
            "address": "kira1ke8qu2p26auyyjysuna5eqmctxkgyy2jvrphe2",
            "pub_key": null,
            "account_number": "1",
            "sequence": "0"
          }
        ]
      },
      "bank": {
        "params": {"send_enabled": [], "default_send_enabled": true},
        "balances": [
          {
            "address": "kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457",
            "coins": [
              {"denom": "lol", "amount": "1000000"},
              {"denom": "samolean", "amount": "2000000000000000000000000000"},
              {"denom": "test", "amount": "300000000000000"},
              {"denom": "ukex", "amount": "150000000000000"}
            ]
          },
          {
            "address": "kira1ke8qu2p26auyyjysuna5eqmctxkgyy2jvrphe2",
            "coins": [
              {"denom": "lol", "amount": "1000000"},
              {"denom": "samolean", "amount": "2000000000000000000000000000"},
              {"denom": "test", "amount": "300000000000000"},
              {"denom": "ukex", "amount": "150000000000000"}
            ]
          }
        ],
        "supply": [],
        "denom_metadata": [],
        "send_enabled": []
      },
      "basket": {"baskets": [], "last_basket_id": "0", "historical_mints": [], "historical_burns": [], "historical_swaps": []},
      "collectives": {"collectives": [], "contributers": []},
      "consensus": null,
      "custody": {},
      "customevidence": {"evidence": []},
      "customgov": {
        "default_denom": "ukex",
        "bech32_prefix": "kira",
        "starting_proposal_id": "1",
        "next_role_id": "3",
        "roles": [
          {"id": 1, "sid": "sudo", "description": "Sudo role"},
          {"id": 2, "sid": "validator", "description": "Validator role"}
        ],
        "role_permissions": {
          "1": {
            "blacklist": [],
            "whitelist": [
              1,
              2,
              3,
              6,
              8,
              9,
              12,
              13,
              10,
              11,
              14,
              15,
              18,
              19,
              20,
              21,
              22,
              23,
              31,
              32,
              24,
              25,
              16,
              17,
              4,
              5,
              26,
              27,
              28,
              29,
              30,
              33,
              34,
              35,
              36,
              37,
              38,
              39,
              40,
              41,
              42,
              43,
              44,
              45,
              46,
              47,
              48,
              49,
              50,
              51,
              52,
              53,
              54,
              55,
              56,
              57,
              58,
              59,
              60,
              61,
              62,
              63,
              64,
              65,
              66
            ]
          },
          "2": {
            "blacklist": [],
            "whitelist": [2]
          }
        },
        "network_actors": [
          {
            "address": "kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457",
            "roles": ["1"],
            "status": "ACTIVE",
            "votes": ["VOTE_OPTION_YES", "VOTE_OPTION_ABSTAIN", "VOTE_OPTION_NO", "VOTE_OPTION_NO_WITH_VETO"],
            "permissions": {"blacklist": [], "whitelist": []},
            "skin": "1"
          }
        ],
        "network_properties": {
          "min_tx_fee": "100",
          "max_tx_fee": "1000000",
          "vote_quorum": "33",
          "minimum_proposal_end_time": "300",
          "proposal_enactment_time": "300",
          "min_proposal_end_blocks": "2",
          "min_proposal_enactment_blocks": "1",
          "enable_foreign_fee_payments": true,
          "mischance_rank_decrease_amount": "10",
          "max_mischance": "110",
          "mischance_confidence": "10",
          "inactive_rank_decrease_percent": "0.500000000000000000",
          "min_validators": "1",
          "poor_network_max_bank_send": "1000000",
          "unjail_max_time": "600",
          "enable_token_whitelist": false,
          "enable_token_blacklist": true,
          "min_identity_approval_tip": "200",
          "unique_identity_keys": "moniker,username",
          "ubi_hardcap": "6000000",
          "validators_fee_share": "0.500000000000000000",
          "inflation_rate": "0.180000000000000000",
          "inflation_period": "31557600",
          "unstaking_period": "2629800",
          "max_delegators": "100",
          "min_delegation_pushout": "10",
          "slashing_period": "3600",
          "max_jailed_percentage": "0.250000000000000000",
          "max_slashing_percentage": "0.010000000000000000",
          "min_custody_reward": "200",
          "max_custody_buffer_size": "10",
          "max_custody_tx_size": "8192",
          "abstention_rank_decrease_amount": "1",
          "max_abstention": "2",
          "min_collective_bond": "100000",
          "min_collective_bonding_time": "86400",
          "max_collective_outputs": "10",
          "min_collective_claim_period": "14400",
          "validator_recovery_bond": "300000",
          "max_annual_inflation": "0.350000000000000000",
          "max_proposal_title_size": "128",
          "max_proposal_description_size": "1024",
          "max_proposal_poll_option_size": "64",
          "max_proposal_poll_option_count": "128",
          "max_proposal_reference_size": "512",
          "max_proposal_checksum_size": "128",
          "min_dapp_bond": "1000000",
          "max_dapp_bond": "10000000",
          "dapp_liquidation_threshold": "0",
          "dapp_liquidation_period": "0",
          "dapp_bond_duration": "604800",
          "dapp_verifier_bond": "0.001000000000000000",
          "dapp_auto_denounce_time": "60",
          "dapp_mischance_rank_decrease_amount": "1",
          "dapp_max_mischance": "10",
          "dapp_inactive_rank_decrease_percent": "10",
          "dapp_pool_slippage_default": "0.100000000000000000",
          "minting_ft_fee": "100000000000000",
          "minting_nft_fee": "100000000000000",
          "veto_threshold": "33.400000000000000000",
          "autocompound_interval_num_blocks": "17280"
        },
        "execution_fees": [
          {"transaction_type": "claim-validator", "execution_fee": "100", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "claim-councilor", "execution_fee": "100", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "claim-proposal-type-x", "execution_fee": "100", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "vote-proposal-type-x", "execution_fee": "100", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "submit-proposal-type-x", "execution_fee": "10", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "veto-proposal-type-x", "execution_fee": "100", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "upsert-token-alias", "execution_fee": "100", "failure_fee": "1", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "activate", "execution_fee": "100", "failure_fee": "1000", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "pause", "execution_fee": "100", "failure_fee": "100", "timeout": "10", "default_parameters": "0"},
          {"transaction_type": "unpause", "execution_fee": "100", "failure_fee": "100", "timeout": "10", "default_parameters": "0"}
        ],
        "poor_network_messages": {
          "messages": [
            "submit-proposal",
            "set-network-properties",
            "vote-proposal",
            "claim-councilor",
            "whitelist-permissions",
            "blacklist-permissions",
            "create-role",
            "assign-role",
            "unassign-role",
            "whitelist-role-permission",
            "blacklist-role-permission",
            "remove-whitelist-role-permission",
            "remove-blacklist-role-permission",
            "claim-validator",
            "activate",
            "pause",
            "unpause",
            "register-identity-records",
            "edit-identity-record",
            "request-identity-records-verify",
            "handle-identity-records-verify-request",
            "cancel-identity-records-verify-request"
          ]
        },
        "proposals": [],
        "votes": [],
        "data_registry": {},
        "identity_records": [
          {
            "id": "1",
            "address": "kira1qffxre9m4dakekdqlsz9pez95crytqj6q8h457",
            "key": "moniker",
            "value": "GENESIS VALIDATOR",
            "date": "2023-11-28T08:58:25.699822776Z",
            "verifiers": []
          }
        ],
        "last_identity_record_id": "1",
        "id_records_verify_requests": [],
        "last_id_record_verify_request_id": "0",
        "proposal_durations": {}
      },
      "customslashing": {
        "params": {"downtime_inactive_duration": "600s"},
        "signing_infos": []
      },
      "customstaking": {
        "validators": [
          {
            "val_key": "kiravaloper1qffxre9m4dakekdqlsz9pez95crytqj6nptkvj",
            "pub_key": {"@type": "/cosmos.crypto.ed25519.PubKey", "key": "FENMOAnaO2TAXP86dt7wVAhZG/Zs09f/En9AHhUVrZ4="},
            "status": "ACTIVE",
            "rank": "0",
            "streak": "0"
          }
        ]
      },
      "distributor": {
        "fees_treasury": [],
        "fees_collected": [],
        "snap_period": "1000",
        "validator_votes": [],
        "previous_proposer": "",
        "year_start_snapshot": {"snapshot_time": "0", "snapshot_amount": "0"},
        "periodic_snapshot": {"snapshot_time": "0", "snapshot_amount": "0"}
      },
      "feeprocessing": {},
      "genutil": {"gen_txs": []},
      "layer2": {
        "dapps": [],
        "bridge": {"helper": null, "accounts": [], "tokens": [], "xams": []}
      },
      "multistaking": null,
      "params": null,
      "recovery": {"recovery_records": [], "recovery_tokens": [], "rewards": [], "rotations": []},
      "spending": {
        "pools": [
          {
            "name": "ValidatorBasicRewardsPool",
            "claim_start": "0",
            "claim_end": "0",
            "claim_expiry": "0",
            "rates": [
              {"denom": "ukex", "amount": "385.000000000000000000"}
            ],
            "vote_quorum": "33",
            "vote_period": "300",
            "vote_enactment": "300",
            "owners": {
              "owner_roles": ["2"],
              "owner_accounts": []
            },
            "beneficiaries": {
              "roles": [
                {"role": "2", "weight": "1.000000000000000000"}
              ],
              "accounts": []
            },
            "balances": [],
            "dynamic_rate": false,
            "dynamic_rate_period": "0",
            "last_dynamic_rate_calc_time": "0"
          }
        ],
        "claims": []
      },
      "tokens": {
        "aliases": [
          {
            "symbol": "KEX",
            "name": "Kira",
            "icon": "",
            "decimals": 6,
            "denoms": ["ukex", "mkex"],
            "invalidated": false
          }
        ],
        "rates": [
          {
            "denom": "ukex",
            "fee_rate": "1.000000000000000000",
            "fee_payments": true,
            "stake_cap": "0.500000000000000000",
            "stake_min": "1",
            "stake_token": true,
            "invalidated": false
          },
          {
            "denom": "ubtc",
            "fee_rate": "10.000000000000000000",
            "fee_payments": true,
            "stake_cap": "0.250000000000000000",
            "stake_min": "1",
            "stake_token": true,
            "invalidated": false
          },
          {
            "denom": "xeth",
            "fee_rate": "0.100000000000000000",
            "fee_payments": true,
            "stake_cap": "0.100000000000000000",
            "stake_min": "1",
            "stake_token": false,
            "invalidated": false
          },
          {
            "denom": "frozen",
            "fee_rate": "0.100000000000000000",
            "fee_payments": true,
            "stake_cap": "0.000000000000000000",
            "stake_min": "1",
            "stake_token": false,
            "invalidated": false
          }
        ],
        "tokenBlackWhites": {
          "whitelisted": ["ukex"],
          "blacklisted": ["frozen"]
        }
      },
      "ubi": {
        "ubi_records": [
          {
            "name": "ValidatorBasicRewardsPoolUBI",
            "distribution_start": "0",
            "distribution_end": "0",
            "distribution_last": "0",
            "amount": "500000",
            "period": "2592000",
            "pool": "ValidatorBasicRewardsPool",
            "dynamic": true
          }
        ]
      },
      "upgrade": {"version": "", "current_plan": null, "next_plan": null}
    }
  };
}
