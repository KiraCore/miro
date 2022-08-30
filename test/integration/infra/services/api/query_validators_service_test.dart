import 'package:dio/dio.dart';
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
// fvm flutter test test/integration/infra/services/api/query_validators_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  group('Tests of getValidatorsList() method', () {
    test('Should return list of validator models', () async {
      QueryValidatorsReq queryValidatorsReq = QueryValidatorsReq();

      TestUtils.printInfo('Data request');
      try {
        List<ValidatorModel> actualValidatorModels = await queryValidatorsService.getValidatorsList(queryValidatorsReq);

        TestUtils.printInfo('Data return');
        String responseString = actualValidatorModels.toString();
        int responseLength = responseString.length;

        print('${responseString.substring(0, 1000 < responseLength ? 1000 : responseLength)} ....');
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch List<ValidatorModel> for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse List<ValidatorModel> for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of getValidatorsByAddresses() method', () {
    test('Should return list of validator models by specified addresses', () async {
      List<String> validatorAddressList = <String>[
        'kira1mpqwqe3zhejalh9zveumy3uduess5p8n09wjmh',
        'kira1wmexfgtah5yrezm9fktflfr9d29t523czqhehj',
        'kira1jss2r7q56k65tvfwe8s5xxdt0av2uvjdulh8kq,'
      ];

      TestUtils.printInfo('Data request');
      try {
        List<ValidatorModel>? validatorModels = await queryValidatorsService.getValidatorsByAddresses(validatorAddressList);

        TestUtils.printInfo('Data return');
        print(validatorModels);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch List<ValidatorModel> for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse List<ValidatorModel> for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of getQueryValidatorsResp() method', () {
    test('Should return list of validators with status & waiting & validators fields', () async {
      QueryValidatorsReq queryValidatorsReq = QueryValidatorsReq(all: true);

      TestUtils.printInfo('Data request');
      try {
        QueryValidatorsResp? queryValidatorsResp = await queryValidatorsService.getQueryValidatorsResp(queryValidatorsReq);

        TestUtils.printInfo('Data return');

        String responseString = queryValidatorsResp.toString();
        int responseLength = responseString.length;

        print('${responseString.substring(0, 1000 < responseLength ? 1000 : responseLength)} ....');
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch List<ValidatorModel> for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse List<ValidatorModel> for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of getStatus() method', () {
    test('Should return validator status only', () async {
      TestUtils.printInfo('Data request');
      try {
        Status? status = await queryValidatorsService.getStatus(networkUri);

        TestUtils.printInfo('Data return');
        print(status);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch Status for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse Status for URI $networkUri: ${e}');
      }
    });
  });
}
