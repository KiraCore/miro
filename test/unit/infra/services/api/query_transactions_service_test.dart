import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api/query_transactions_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryTransactionsService actualQueryTransactionsService = globalLocator<QueryTransactionsService>();

  List<TxListItemModel> expectedTxListItemModelList = <TxListItemModel>[
    TxListItemModel(hash: '0x3BD165E428985C8FE60A93A9AF0B502F6735F54892FE27425465FAAA04B42BDA'),
    TxListItemModel(hash: '0x5372F94173105AE3DE4A19CA30A02F1590437F823D45E43EAFC589199C2BC2A2'),
    TxListItemModel(hash: '0x99BA327FE4299E6654BDD082E147A2C58A5DC513DB754A3A78EB3960142613BB'),
    TxListItemModel(hash: '0x529CF7D991FE7C9FDF115378AD3559AB18EC5DA8C4CF29EC1EC525E01720238B'),
    TxListItemModel(hash: '0x25FD76956C6C1BD814E9376D78BE87511E41ABA1F24264AF455EEC600CB1961B'),
    TxListItemModel(hash: '0xFAB7C1AC4E8CF8C87D3100B6F601151C77927997B103940E9995DA1207C0E032'),
    TxListItemModel(hash: '0x2114D4CE6A7F85F798A6B4B44AEE2E639CCEE7551152D51367ABD4DC95154D0F'),
  ];

  group('Tests of QueryTransactionsService.getTransactionList() method', () {
    test('Should return List<TxListItemModel> if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

      // Act
      List<TxListItemModel> actualTxListItemModelList = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

      //Assert
      expect(actualTxListItemModelList, expectedTxListItemModelList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

      // Assert
      expect(
        () => actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

      // Assert
      expect(
        () => actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
