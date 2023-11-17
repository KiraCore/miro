import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/request/query_delegations_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_delegations_service.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_delegations_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryDelegationsService actualQueryDelegationsService = globalLocator<QueryDelegationsService>();

  group('Tests of QueryDelegationsService.getValidatorStakingModelList() method', () {
    test('Should return [PageData<ValidatorStakingModel>]', () async {
      QueryDelegationsReq actualQueryDelegationsReq = const QueryDelegationsReq(
        delegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        limit: 10,
        offset: 0,
      );

      TestUtils.printInfo('Data request');
      try {
        PageData<ValidatorStakingModel> actualValidatorStakingPageData =
            await actualQueryDelegationsService.getValidatorStakingModelList(actualQueryDelegationsReq);

        TestUtils.printInfo('Data return');
        print(actualValidatorStakingPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_delegations_service_test.dart: Cannot fetch [PageData<ValidatorStakingModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_delegations_service_test.dart: Cannot parse [PageData<ValidatorStakingModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_delegations_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
