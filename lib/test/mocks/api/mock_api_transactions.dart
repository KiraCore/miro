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
    ],
    "total_count": 35
  };
}
