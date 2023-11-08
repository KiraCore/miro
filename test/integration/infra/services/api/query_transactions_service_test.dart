import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_sort_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_transactions_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryTransactionsService actualQueryTransactionsService = globalLocator<QueryTransactionsService>();
  const String actualWalletAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

  group('Tests of QueryTransactionsService.getTransactionList() method', () {
    test('Should return [PageData<TxListItemModel>] after query [without optional query parameters]', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: actualWalletAddress, limit: 10, offset: 0);
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should return [PageData<TxListItemModel>] after query with [dateStart, dateEnd] query parameters', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = QueryTransactionsReq(
          address: actualWalletAddress,
          dateStart: CustomDateUtils.buildDateFromSecondsSinceEpoch(1672651150),
          dateEnd: CustomDateUtils.buildDateFromSecondsSinceEpoch(1672669166),
          limit: 10,
          offset: 0,
        );
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should return [PageData<TxListItemModel>] after query with [direction] query parameter', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(
          address: actualWalletAddress,
          direction: <TxDirectionType>[TxDirectionType.inbound],
          limit: 10,
          offset: 0,
        );
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should return [PageData<TxListItemModel>] after query with [status] query parameter', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(
          address: actualWalletAddress,
          status: <TxStatusType>[TxStatusType.failed],
          limit: 10,
          offset: 0,
        );
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should return [PageData<TxListItemModel>] after query with [type] query parameter', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(
          address: actualWalletAddress,
          type: <TxMsgType>[TxMsgType.msgSend],
          limit: 10,
          offset: 0,
        );
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should return [PageData<TxListItemModel>] after query with [sort] query parameter', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(
          address: actualWalletAddress,
          sort: TxSortType.dateASC,
          limit: 10,
          offset: 0,
        );
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should return [PageData<TxListItemModel>] after query with [limit, offset] query parameters', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryTransactionsReq actualQueryTransactionsReq = const QueryTransactionsReq(address: actualWalletAddress, limit: 10, offset: 0);
        PageData<TxListItemModel> actualTransactionsPageData = await actualQueryTransactionsService.getTransactionList(actualQueryTransactionsReq);

        TestUtils.printInfo('Data return');
        print(actualTransactionsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot fetch [PageData<TxListItemModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Cannot parse [PageData<TxListItemModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_transactions_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
