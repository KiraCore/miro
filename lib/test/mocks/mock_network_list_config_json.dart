class MockNetworkListConfigJson {
  static Map<String, dynamic> defaultNetworkListConfig = <String, dynamic>{
    'refresh_interval_seconds': 60,
    'network_list': [
      {
        'name': 'unhealthy-mainnet',
        'address': 'https://unhealthy.kira.network',
      },
      {
        'name': 'healthy-mainnet',
        'address': 'https://healthy.kira.network',
      },
      {
        'name': 'offline-mainnet',
        'address': 'https://offline.kira.network',
      },
    ]
  };
}
