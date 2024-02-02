class MockApiKiraTokensAliases {
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    "token_aliases_data": [
      {
        "decimals": 6,
        "denoms": ["ukex", "mkex"],
        "name": "Kira",
        "symbol": "KEX",
        "icon": "",
        "amount": "300000000000000"
      }
    ],
    "default_denom": "ukex",
    "bech32_prefix": "kira"
  };
}
