import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_validators_service_test.dart --platform chrome
//ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  group('Tests of getValidators() method', () {
    test('Should return list of validators with status & waiting & validators fields', () async {
      final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();
      final Uri uri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      QueryValidatorsReq queryValidatorsReq = QueryValidatorsReq(all: true);

      testPrint('Data request');
      QueryValidatorsResp? queryValidatorsResp = await queryValidatorsService.getValidators(uri, queryValidatorsReq);

      testPrint('Data return');
      int responseLength = queryValidatorsResp.toString().length;
      print('${queryValidatorsResp.toString().substring(0, 1000)} ....');
      print('.... ${queryValidatorsResp.toString().substring(responseLength - 1800, responseLength)}');
      print('');
    });
  });
}
