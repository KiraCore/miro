class MockApiKiraBalances {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "balances": [
      {"amount": "9878", "denom": "lol"},
      {"amount": "90000000000000000000000000", "denom": "samolean"},
      {"amount": "199779999999631", "denom": "test"},
      {"amount": "856916", "denom": "ukex"}
    ],
    "pagination": {"total": "4"}
  };
}
