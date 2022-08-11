import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/test/mock_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/config/app_config_test.dart --platform chrome
Future<void> main() async {
  await initMockLocator();

  group('Tests of init() method for "refresh_interval_seconds" property', () {
    test('Should return interval value declared in config json ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'refresh_interval_seconds': 70,
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      Duration expectedRefreshInterval = const Duration(seconds: 70);

      expect(actualAppConfig.refreshInterval, expectedRefreshInterval);
    });

    test('Should return default interval value (60 seconds) if "refresh_interval_seconds" is smaller than 60 ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'refresh_interval_seconds': 30,
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      Duration expectedRefreshInterval = const Duration(seconds: 60);

      expect(actualAppConfig.refreshInterval, expectedRefreshInterval);
    });

    test('Should return default interval value (60 seconds) if "refresh_interval_seconds" has typo ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'refresh_interval_seconds_with_typo': 60,
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      Duration expectedRefreshInterval = const Duration(seconds: 60);

      expect(actualAppConfig.refreshInterval, expectedRefreshInterval);
    });

    test('Should return default interval value (60 seconds) if "refresh_interval_seconds" has invalid value ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'refresh_interval_seconds': 'there should be integer, but is some string',
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      Duration expectedRefreshInterval = const Duration(seconds: 60);
      expect(actualAppConfig.refreshInterval, expectedRefreshInterval);
    });

    test('Should return default interval value (60 seconds) if "refresh_interval_seconds" not exists ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{};

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      Duration expectedRefreshInterval = const Duration(seconds: 60);

      expect(actualAppConfig.refreshInterval, expectedRefreshInterval);
    });
  });

  group('Tests of init() method for "refresh_interval_seconds" property', () {
    NetworkUnknownModel defaultNetworkUnknownModel = NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: Uri.parse('https://testnet-rpc.kira.network'),
    );
    NetworkUnknownModel healthyNetworkUnknownModel = NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: Uri.parse('https://healthy.kira.network'),
      name: 'healthy-mainnet',
    );
    NetworkUnknownModel unhealthyNetworkUnknownModel = NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: Uri.parse('https://unhealthy.kira.network'),
      name: 'unhealthy-mainnet',
    );
    NetworkUnknownModel offlineNetworkUnknownModel = NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: Uri.parse('https://offline.kira.network'),
      name: 'offline-mainnet',
    );

    test('Should return network list from config ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'network_list': <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'unhealthy-mainnet',
            'address': 'https://unhealthy.kira.network',
          },
          <String, dynamic>{
            'name': 'healthy-mainnet',
            'address': 'https://healthy.kira.network',
          },
          <String, dynamic>{
            'name': 'offline-mainnet',
            'address': 'https://offline.kira.network',
          },
        ]
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        unhealthyNetworkUnknownModel,
        healthyNetworkUnknownModel,
        offlineNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });

    test('Should skip list items with invalid or not existing "address" field and return network list without them ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'network_list': <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'unhealthy-mainnet',
            'invalid_address': 'https://unhealthy.kira.network',
          },
          <String, dynamic>{
            'invalid_name': 'healthy-mainnet',
            'address': 'https://healthy.kira.network',
          },
          <String, dynamic>{
            'invalid_name': 'without-address',
          },
          <String, dynamic>{
            'name': 'offline-mainnet',
            'address': 'https://offline.kira.network',
          },
        ]
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        NetworkUnknownModel(uri: Uri.parse('https://healthy.kira.network'), connectionStatusType: ConnectionStatusType.disconnected),
        offlineNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });

    test('Should return defaultNetworkUnknownModel if all list item has invalid or not existing address field ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'network_list': <Map<String, dynamic>>[
          <String, dynamic>{
            'invalid_address': 'https://unhealthy.kira.network',
          },
          <String, dynamic>{},
          <String, dynamic>{
            'invalid_address': 'https://offline.kira.network',
          },
        ]
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        defaultNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });

    test('Should return defaultNetworkUnknownModel if "network_list" value has empty list', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{'network_list': <Map<String, dynamic>>[]};

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        defaultNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });

    test('Should return defaultNetworkUnknownModel if "network_list" has typo', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'network_list_with_typo': <Map<String, dynamic>>[
          <String, dynamic>{
            'name': 'unhealthy-mainnet',
            'address': 'https://unhealthy.kira.network',
          },
        ]
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        defaultNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });

    test('Should return defaultNetworkUnknownModel if "network_list" has invalid value', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{
        'network_list': 'there should be list of networks, but is some string',
      };

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        defaultNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });

    test('Should return defaultNetworkUnknownModel if "network_list" not exists ', () {
      // Arrange
      Map<String, dynamic> configJson = <String, dynamic>{};

      // Act
      AppConfig actualAppConfig = AppConfig()..init(configJson);

      // Assert
      List<NetworkUnknownModel> expectedNetworkUnknownModelList = <NetworkUnknownModel>[
        defaultNetworkUnknownModel,
      ];

      expect(actualAppConfig.networkList, expectedNetworkUnknownModelList);
    });
  });

  group('Tests of findNetworkModelInConfig()', () {
    test('Should return NetworkUnknownModel from method argument if network doesn`t exists in config', () {
      // Arrange
      AppConfig appConfig = globalLocator<AppConfig>();
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://not.exist.kira.network'),
      );

      // Act
      NetworkUnknownModel actualNetworkUnknownModel = appConfig.findNetworkModelInConfig(networkUnknownModel);

      // Assert
      NetworkUnknownModel expectedNetworkUnknownModel = networkUnknownModel;

      expect(actualNetworkUnknownModel, expectedNetworkUnknownModel);
    });

    test('Should return NetworkUnknownModel from config if network exists in config', () {
      // Arrange
      AppConfig appConfig = globalLocator<AppConfig>();
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://unhealthy.kira.network'),
      );

      // Act
      NetworkUnknownModel actualNetworkUnknownModel = appConfig.findNetworkModelInConfig(networkUnknownModel);

      // Assert
      NetworkUnknownModel expectedNetworkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://unhealthy.kira.network'),
        name: 'unhealthy-mainnet',
      );

      expect(actualNetworkUnknownModel, expectedNetworkUnknownModel);
    });
  });

  group('Tests of getDefaultNetworkUnknownModel()', () {
    test('Should return NetworkUnknownModel as a first element of config network list', () async {
      // Arrange
      AppConfig appConfig = globalLocator<AppConfig>();

      // Act
      NetworkUnknownModel actualNetworkUnknownModel = await appConfig.getDefaultNetworkUnknownModel();

      // Assert
      NetworkUnknownModel expectedNetworkUnknownModel = appConfig.networkList.first;

      expect(
        actualNetworkUnknownModel,
        expectedNetworkUnknownModel,
      );
    });

    test('Should return NetworkUnknownModel created from "rpc" query param existing in browser URL', () async {
      // Arrange
      AppConfig appConfig = globalLocator<AppConfig>();
      RpcBrowserUrlController rpcBrowserUrlController = RpcBrowserUrlController();
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://unhealthy.kira.network'),
        name: 'unhealthy-mainnet',
      );
      rpcBrowserUrlController.setRpcAddress(networkUnknownModel);

      // Act
      NetworkUnknownModel actualNetworkUnknownModel = await appConfig.getDefaultNetworkUnknownModel();

      // Assert
      NetworkUnknownModel expectedNetworkUnknownModel = networkUnknownModel;

      expect(
        actualNetworkUnknownModel,
        expectedNetworkUnknownModel,
      );
    });
  });
}
