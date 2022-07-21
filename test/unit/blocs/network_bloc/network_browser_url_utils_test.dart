import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network/utils/network_browser_url_utils.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_bloc/network_browser_url_utils_test.dart --platform chrome
Future<void> main() async {
  group('Tests of getNetworkAddress method', () {
    test('Should return network address from given url', () {
      // Act
      Uri mockedBrowserUrl = Uri.parse('https://miro.kira.network?rpc=https://online.kira.network');
      String? actualNetworkAddress = NetworkBrowserUrlUtils.getNetworkAddress(optionalNetworkUri: mockedBrowserUrl);

      // Assert
      String expectedNetworkAddress = 'https://online.kira.network';
      expect(actualNetworkAddress, expectedNetworkAddress);
    });

    test('Should return network address from given url when url have more than one query param', () {
      // Act
      Uri mockedBrowserUrl = Uri.parse(
        'https://miro.kira.network?rpc=https://online.kira.network&page=account&type=transaction&id=1',
      );
      String? actualNetworkAddress = NetworkBrowserUrlUtils.getNetworkAddress(optionalNetworkUri: mockedBrowserUrl);

      // Assert
      String expectedNetworkAddress = 'https://online.kira.network';
      expect(actualNetworkAddress, expectedNetworkAddress);
    });

    test('Should return network address from given url when url have additional path', () {
      // Act
      Uri mockedBrowserUrl = Uri.parse('https://miro.kira.network/user/details?rpc=https://online.kira.network');
      String? actualNetworkAddress = NetworkBrowserUrlUtils.getNetworkAddress(optionalNetworkUri: mockedBrowserUrl);

      // Assert
      String expectedNetworkAddress = 'https://online.kira.network';
      expect(actualNetworkAddress, expectedNetworkAddress);
    });

    test('Should return network address from given url when url have additional path and multiple query params', () {
      // Act
      Uri mockedBrowserUrl = Uri.parse(
        'https://miro.kira.network/user/details?rpc=https://online.kira.network&page=account&type=transaction&id=1',
      );
      String? actualNetworkAddress = NetworkBrowserUrlUtils.getNetworkAddress(optionalNetworkUri: mockedBrowserUrl);

      // Assert
      String expectedNetworkAddress = 'https://online.kira.network';
      expect(actualNetworkAddress, expectedNetworkAddress);
    });
  });

  group('Tests of addNetworkAddress method', () {
    test('Should add network address into browser url from given address', () {
      // Arrange
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: Uri.parse('https://testnet-rpc.kira.network'));

      // Act
      NetworkBrowserUrlUtils.addNetworkAddress(networkUnknownModel);

      // Assert
      Uri actualBrowserUrl = Uri.base;
      String expectedNetworkAddress = 'https://testnet-rpc.kira.network';
      expect(
        actualBrowserUrl.queryParameters['rpc'],
        expectedNetworkAddress,
      );
    });
  });

  group('Tests of getQueryParametersForNetwork method', () {
    test('Should add network address into browser url from given address', () {
      // Arrange
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: Uri.parse('https://testnet-rpc.kira.network'));
      Map<String, dynamic> previouslyExistedQueryParams = <String, dynamic>{
        'account': '0x123',
        'page': 'account',
        'type': 'transaction',
        'id': '1',
      };

      // Act
      Map<String, dynamic> actualQueryParameters = NetworkBrowserUrlUtils.getQueryParametersForNetwork(
        previouslyExistedQueryParams,
        networkUnknownModel,
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
  });

  group('Tests of removeNetworkAddress method', () {
    test('Should remove network address from browser url', () {
      // Arrange
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: Uri.parse('https://testnet-rpc.kira.network'));
      NetworkBrowserUrlUtils.addNetworkAddress(networkUnknownModel);

      // We have to use addNetworkAddress before actual test, because we need to have network address in browser url
      // Check if environment is correct:
      Uri actualBrowserUrl = Uri.base;
      String expectedNetworkAddress = 'https://testnet-rpc.kira.network';
      testPrint('Should return https://testnet-rpc.kira.network as network address from browser url');
      expect(
        actualBrowserUrl.queryParameters['rpc'],
        expectedNetworkAddress,
      );

      // Act
      NetworkBrowserUrlUtils.removeNetworkAddress();

      // Assert
      actualBrowserUrl = Uri.base;
      expect(
        actualBrowserUrl.queryParameters['rpc'],
        null,
      );
    });
  });
}
