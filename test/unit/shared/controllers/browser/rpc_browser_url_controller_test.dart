import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

import 'mock_data/mock_browser_url_controller.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/controllers/browser/rpc_browser_url_controller_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
Future<void> main() async {
  group('Tests of getRpcAddress method', () {
    test('Should return rpc address from given url', () {
      // Arrange
      Uri mockedBrowserUrl = Uri.parse(
        'https://miro.kira.network?rpc=https://unhealthy.kira.network',
      );
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: mockedBrowserUrl),
      );

      // Assert
      String expectedNetworkAddress = 'https://unhealthy.kira.network';

      expect(
        actualRpcBrowserUrlController.getRpcAddress(),
        expectedNetworkAddress,
      );
    });

    test('Should return null if url has rpc param but it`s empty', () {
      // Arrange
      Uri mockedBrowserUrl = Uri.parse(
        'https://miro.kira.network?rpc=',
      );
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: mockedBrowserUrl),
      );

      // Assert
      expect(
        actualRpcBrowserUrlController.getRpcAddress(),
        null,
      );
    });

    test('Should return rpc address from given url when url have more than one query parameter', () {
      // Arrange
      Uri mockedBrowserUrl = Uri.parse(
        'https://miro.kira.network?rpc=https://unhealthy.kira.network&page=account&type=transaction&id=1',
      );
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: mockedBrowserUrl),
      );

      // Assert
      String expectedNetworkAddress = 'https://unhealthy.kira.network';

      expect(
        actualRpcBrowserUrlController.getRpcAddress(),
        expectedNetworkAddress,
      );
    });

    test('Should return rpc address from given url when url have additional path parameters', () {
      // Arrange
      Uri mockedBrowserUrl = Uri.parse('https://miro.kira.network/user/details?rpc=https://unhealthy.kira.network');
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: mockedBrowserUrl),
      );

      // Assert
      String expectedNetworkAddress = 'https://unhealthy.kira.network';

      expect(
        actualRpcBrowserUrlController.getRpcAddress(),
        expectedNetworkAddress,
      );
    });

    test('Should return rpc address from given url when url have additional path and multiple query params', () {
      // Arrange
      Uri mockedBrowserUrl = Uri.parse(
        'https://miro.kira.network/user/details?rpc=https://unhealthy.kira.network&page=account&type=transaction&id=1',
      );
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: mockedBrowserUrl),
      );

      // Assert
      String expectedNetworkAddress = 'https://unhealthy.kira.network';

      expect(
        actualRpcBrowserUrlController.getRpcAddress(),
        expectedNetworkAddress,
      );
    });
  });

  group('Tests of setRpcAddress method', () {
    test('Should add rpc address into browser url from given address', () {
      // Arrange
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: Uri.parse('https://miro.kira.network')),
      );
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://testnet-rpc.kira.network'),
      );

      // Act
      actualRpcBrowserUrlController.setRpcAddress(networkUnknownModel);
      Map<String, dynamic> actualQueryParameters = actualRpcBrowserUrlController.browserUrlController.extractQueryParameters();
      
      // Assert
      String expectedNetworkAddress = 'https://testnet-rpc.kira.network';

      expect(
        actualQueryParameters['rpc'],
        expectedNetworkAddress,
      );
    });
  });

  group('Tests of extractQueryParameters method', () {
    test('Should return map of query parameters with added rpc param ', () {
      // Arrange
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: Uri.parse('https://miro.kira.network')),
      );
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://testnet-rpc.kira.network'),
      );
      Map<String, dynamic> previouslyExistedQueryParams = <String, dynamic>{
        'account': '0x123',
        'page': 'account',
        'type': 'transaction',
        'id': '1',
      };

      // Act
      Map<String, dynamic> actualQueryParameters = actualRpcBrowserUrlController.extractQueryParameters(
        currentQueryParameters: previouslyExistedQueryParams,
        networkStatusModel: networkUnknownModel,
      );

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{
        'account': '0x123',
        'page': 'account',
        'type': 'transaction',
        'id': '1',
        'rpc': 'https://testnet-rpc.kira.network',
      };

      expect(
        actualQueryParameters,
        expectedQueryParameters,
      );
    });

    test('Should return map of query parameters with removed rpc param', () {
      // Arrange
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: Uri.parse('https://miro.kira.network')),
      );

      Map<String, dynamic> previouslyExistedQueryParams = <String, dynamic>{
        'account': '0x123',
        'page': 'account',
        'type': 'transaction',
        'rpc': 'https://testnet-rpc.kira.network',
        'id': '1',
      };

      // Act
      Map<String, dynamic> actualQueryParameters = actualRpcBrowserUrlController.extractQueryParameters(
        currentQueryParameters: previouslyExistedQueryParams,
        networkStatusModel: null,
      );

      // Assert
      Map<String, dynamic> expectedQueryParameters = <String, dynamic>{
        'account': '0x123',
        'page': 'account',
        'type': 'transaction',
        'id': '1',
      };

      expect(actualQueryParameters, expectedQueryParameters);
    });
  });

  group('Tests of removeRpcAddress method', () {
    test('Should remove rpc address from browser url', () {
      // Arrange
      RpcBrowserUrlController actualRpcBrowserUrlController = RpcBrowserUrlController(
        browserUrlController: MockBrowserUrlController(mockedUri: Uri.parse('https://miro.kira.network?rpc=https://testnet-rpc.kira.network')),
      );

      // Act
      actualRpcBrowserUrlController.removeRpcAddress();
      Map<String, dynamic> actualQueryParameters = actualRpcBrowserUrlController.browserUrlController.extractQueryParameters();
      
      // Assert
      expect(
        actualQueryParameters['rpc'],
        null,
      );
    });
  });
}
