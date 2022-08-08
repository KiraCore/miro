import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_validators_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  group('Tests of getValidatorsList() method', () {
    test('Should return list of validator models', () async {
      final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      QueryValidatorsReq queryValidatorsReq = QueryValidatorsReq();

      testPrint('Data request');
      List<ValidatorModel>? validatorModels = await queryValidatorsService.getValidatorsList(
        queryValidatorsReq,
        optionalNetworkUri: networkUri,
      );

      testPrint('Data return');
      int responseLength = validatorModels.toString().length;
      print('${validatorModels.toString().substring(0, 1000)} ....');
      print('.... ${validatorModels.toString().substring(responseLength - 1800, responseLength)}');
      print('');
    });
  });

  group('Tests of getValidatorsByAddresses() method', () {
    test('Should return list of validator models by specified addresses', () async {
      final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      testPrint('Data request');
      List<ValidatorModel>? validatorModels = await queryValidatorsService.getValidatorsByAddresses(
        <String>[
          'kira1mpqwqe3zhejalh9zveumy3uduess5p8n09wjmh',
          'kira1wmexfgtah5yrezm9fktflfr9d29t523czqhehj',
          'kira1jss2r7q56k65tvfwe8s5xxdt0av2uvjdulh8kq,'
        ],
        optionalNetworkUri: networkUri,
      );

      testPrint('Data return');
      print(validatorModels);
      print('');
    });
  });

  group('Tests of getQueryValidatorsResp() method', () {
    test('Should return list of validators with status & waiting & validators fields', () async {
      final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      QueryValidatorsReq queryValidatorsReq = QueryValidatorsReq(all: true);

      testPrint('Data request');
      QueryValidatorsResp? queryValidatorsResp =
          await queryValidatorsService.getQueryValidatorsResp(queryValidatorsReq, optionalNetworkUri: networkUri);

      testPrint('Data return');
      int responseLength = queryValidatorsResp.toString().length;
      print('${queryValidatorsResp.toString().substring(0, 1000)} ....');
      print('.... ${queryValidatorsResp.toString().substring(responseLength - 1800, responseLength)}');
      print('');
    });
  });

  group('Tests of getStatus() method', () {
    test('Should return validator status only', () async {
      final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      testPrint('Data request');
      Status? status = await queryValidatorsService.getStatus(networkUri);

      testPrint('Data return');
      print(status);
      print('');
    });
  });
}
