import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_account_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryAccountService actualQueryAccountService = globalLocator<QueryAccountService>();
  const String actualAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

  group('Tests of QueryAccountService.getTxRemoteInfo() method', () {
    test('Should return [TxRemoteInfoModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      TxRemoteInfoModel? actualTxRemoteInfoModel = await actualQueryAccountService.getTxRemoteInfo(actualAddress);

      // Act
      TxRemoteInfoModel expectedTxRemoteInfoModel = const TxRemoteInfoModel(
        accountNumber: '669',
        chainId: 'testnet-9',
        sequence: '106',
      );
      expect(actualTxRemoteInfoModel, expectedTxRemoteInfoModel);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => actualQueryAccountService.getTxRemoteInfo(actualAddress),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => actualQueryAccountService.getTxRemoteInfo(actualAddress),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of QueryAccountService.isAccountRegistered() method', () {
    test('Should return [true] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      bool actualFetchAvailableBool = await actualQueryAccountService.isAccountRegistered(actualAddress);

      // Assert
      expect(actualFetchAvailableBool, true);
    });

    test('Should return [false] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      bool actualFetchAvailableBool = await actualQueryAccountService.isAccountRegistered(actualAddress);

      // Assert
      expect(actualFetchAvailableBool, false);
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => actualQueryAccountService.isAccountRegistered(actualAddress),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
