import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_staking_pool_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryStakingPoolService actualQueryStakingPoolService = globalLocator<QueryStakingPoolService>();

  group('Tests of QueryStakingPoolService.getStakingPoolModel() method', () {
    test('Should return [StakingPoolModel]', () async {
      WalletAddress actualValidatorWalletAddress = WalletAddress.fromBech32('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');

      TestUtils.printInfo('Data request');
      try {
        StakingPoolModel actualStakingPoolModel = await actualQueryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress);

        TestUtils.printInfo('Data return');
        print(actualStakingPoolModel);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_staking_pool_service_test.dart: Cannot fetch [StakingPoolModel] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_staking_pool_service_test.dart: Cannot parse [StakingPoolModel] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_staking_pool_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
