class MockApiKiraStakingPool {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "id": 1,
    "slashed": "0.0",
    "commission": "0.1",
    "total_delegators": 1,
    "voting_power": [
      {"amount": "100", "denom": "ukex"}
    ],
    "tokens": ["frozen", "ubtc", "ukex", "xeth"]
  };
}
