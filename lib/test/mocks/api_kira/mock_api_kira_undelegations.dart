class MockApiKiraUndelegations {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "undelegations": [
      {
        "id": 2,
        "validator_info": {
          "moniker": "GENESIS VALIDATOR",
          "address": "kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w",
          "valkey": "kiravaloper1ymx5gpvswq0cmj6zkdxwa233sdgq2k5z3056lz",
          "website": "https://twitter.com/",
          "logo": "https://avatars.githubusercontent.com/u/114292385?s=200"
        },
        "tokens": [
          {"denom": "ukex", "amount": "2000"}
        ],
        "expiry": "1701181197"
      }
    ],
    'pagination': {'total': '1'}
  };
}
