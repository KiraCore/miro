class MockApiKiraDelegations {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "delegations": [
      {
        "validator_info": {
          "moniker": "GENESIS VALIDATOR",
          "address": "kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w",
          "valkey": "kiravaloper1ymx5gpvswq0cmj6zkdxwa233sdgq2k5z3056lz",
          "website": "https://twitter.com/",
          "logo": "https://avatars.githubusercontent.com/u/114292385?s=200"
        },
        "pool_info": {
          "id": 1,
          "commission": "0.5",
          "status": "ENABLED",
          "tokens": ["frozen", "ubtc", "ukex", "xeth"]
        }
      }
    ],
    'pagination': {'total': '1'}
  };
}
