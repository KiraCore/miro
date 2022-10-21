class MockApiKiraTokensRates {
  static Map<String, dynamic> defaultResponse = {
    'data': [
      {
        'denom': 'frozen',
        'fee_payments': true,
        'fee_rate': '0.1',
        'stake_cap': '0.0',
        'stake_min': '1e-18.0',
        'stake_token': false,
      },
      {
        'denom': 'ubtc',
        'fee_payments': true,
        'fee_rate': '10.0',
        'stake_cap': '0.25',
        'stake_min': '1e-18.0',
        'stake_token': true,
      },
      {
        'denom': 'ukex',
        'fee_payments': true,
        'fee_rate': '1.0',
        'stake_cap': '0.5',
        'stake_min': '1e-18.0',
        'stake_token': true,
      },
      {
        'denom': 'xeth',
        'fee_payments': true,
        'fee_rate': '0.1',
        'stake_cap': '0.1',
        'stake_min': '1e-18.0',
        'stake_token': false,
      }
    ]
  };
}
