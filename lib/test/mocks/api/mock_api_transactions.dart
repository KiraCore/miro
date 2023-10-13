class MockApiTransactions {
  static Map<String, dynamic> defaultResponse = {
    "transactions": [
      // Msg Send inbound
      {
        "time": 1675093708,
        "hash": "0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX0123456789 !\"#\$%'()*+,-./:;=?@[\\]^_`{|}~",
        "fee": [
          {"denom": "ukex", "amount": "100"}
        ],
        "txs": [
          {
            "amount": [
              {"amount": "100", "denom": "samolean"}
            ],
            "from_address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "to_address": "kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl",
            "type": "send"
          }
        ]
      },
      // MsgSend outbound
      {
        "time": 1672143106,
        "hash": "0x5372F94173105AE3DE4A19CA30A02F1590437F823D45E43EAFC589199C2BC2A2",
        "status": "confirmed",
        "direction": "inbound",
        "memo": "Faucet Transfer",
        "fee": [
          {"denom": "ukex", "amount": "500"}
        ],
        "txs": [
          {
            "amount": [
              {"amount": "20000000", "denom": "test"}
            ],
            "from_address": "kira1m82gva4kqj28ulnk02a8447uumdl26jyegsca4",
            "to_address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "type": "send"
          }
        ]
      },
      // MsgRegisterIdentityRecords
      {
        "time": 1672655830,
        "hash": "0x99BA327FE4299E6654BDD082E147A2C58A5DC513DB754A3A78EB3960142613BB",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgRegisterIdentityRecords message",
        "fee": [
          {"denom": "ukex", "amount": "200"}
        ],
        "txs": [
          {
            "address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "infos": [
              {"info": "https://paganresearch.io/images/kiracore.jpg", "key": "avatar"}
            ],
            "type": "register-identity-records"
          }
        ]
      },
      // MsgRequestIdentityRecordsVerify
      {
        "time": 1672656276,
        "hash": "0x529CF7D991FE7C9FDF115378AD3559AB18EC5DA8C4CF29EC1EC525E01720238B",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgRequestIdentityRecordsVerify message",
        "fee": [
          {"denom": "ukex", "amount": "200"}
        ],
        "txs": [
          {
            "address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "record_ids": [2],
            "tip": {"amount": "200", "denom": "ukex"},
            "type": "request-identity-records-verify",
            "verifier": "kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl"
          }
        ]
      },
      // MsgCancelIdentityRecordsVerifyRequest
      {
        "time": 1672656366,
        "hash": "0x25FD76956C6C1BD814E9376D78BE87511E41ABA1F24264AF455EEC600CB1961B",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgCancelIdentityRecordsVerifyRequest message",
        "fee": [
          {"denom": "ukex", "amount": "200"}
        ],
        "txs": [
          {"executor": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx", "type": "cancel-identity-records-verify-request", "verify_request_id": 1}
        ]
      },
      // MsgDeleteIdentityRecords
      {
        "time": 1672656662,
        "hash": "0xFAB7C1AC4E8CF8C87D3100B6F601151C77927997B103940E9995DA1207C0E032",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgDeleteIdentityRecords message",
        "fee": [
          {"denom": "ukex", "amount": "200"}
        ],
        "txs": [
          {
            "address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "keys": ["website"],
            "type": "edit-identity-record"
          }
        ]
      },
      // MsgHandleIdentityRecordsVerifyRequest
      {
        "time": 1672674563,
        "hash": "0x2114D4CE6A7F85F798A6B4B44AEE2E639CCEE7551152D51367ABD4DC95154D0F",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgHandleIdentityRecordsVerifyRequest message",
        "fee": [
          {"denom": "ukex", "amount": "200"}
        ],
        "txs": [
          {"type": "handle-identity-records-verify-request", "verifier": "kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl", "verify_request_id": 4, "yes": true}
        ]
      },
      // MsgDelegate
      {
        "time": 1672674564,
        "hash": "0x3ADE47F67589A9B8FE75F9E669BBB2FA49B1B010525BD54C75D2F8E94A970F07",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgDelegate message",
        "fee": [
          {"denom": "ukex", "amount": "100"}
        ],
        "txs": [
          {
            "type": "delegate",
            "delegator_address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "validator_address": "kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7",
            "amounts": [
              {"denom": "ukex", "amount": "100"}
            ]
          }
        ]
      },
      // MsgUndelegate
      {
        "time": 1672674565,
        "hash": "0x72873A65DA27D3B1E967EA2BA5364A69BB8C52E8EBB74C599356DEE279543B1A",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgUndelegate message",
        "fee": [
          {"denom": "ukex", "amount": "100"}
        ],
        "txs": [
          {
            "type": "undelegate",
            "delegator_address": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx",
            "validator_address": "kiravaloper1c6slygj2tx7hzm0mn4qeflqpvngj73c2cw7fh7",
            "amounts": [
              {"denom": "ukex", "amount": "100"}
            ]
          }
        ]
      },
      // MsgClaimRewards
      {
        "time": 1672674566,
        "hash": "0x1B3CB7CCBAD84FAAF28F9481B376309B0D63249A466571D6CCDF5FD5C8044434",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgClaimRewards message",
        "fee": [
          {"denom": "ukex", "amount": "100"}
        ],
        "txs": [
          {"type": "claim_rewards", "sender": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx"}
        ]
      },
      // MsgClaimUndelegation
      {
        "time": 1672674567,
        "hash": "0xEB41A34FC3B56EDB29743431C8816F6F33D3C7C0C649DB9E9A3784D9B9EE5FA0",
        "status": "confirmed",
        "direction": "outbound",
        "memo": "Test of MsgClaimUndelegation message",
        "fee": [
          {"denom": "ukex", "amount": "100"}
        ],
        "txs": [
          {"type": "claim_undelegation", "sender": "kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx", "undelegation_id": 1}
        ]
      },
    ],
    "total_count": 11
  };
}
