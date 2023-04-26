import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_validators_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryValidatorsService actualQueryValidatorsService = globalLocator<QueryValidatorsService>();

  group('Tests of QueryValidatorsService.getValidatorsList() method', () {
    test('Should return [List of ValidatorModel]', () async {
      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq();

      TestUtils.printInfo('Data request');
      try {
        List<ValidatorModel> actualValidatorModels = await actualQueryValidatorsService.getValidatorsList(actualQueryValidatorsReq);

        TestUtils.printInfo('Data return');
        String actualResponseString = actualValidatorModels.toString();
        int actualResponseLength = actualResponseString.length;

        print('${actualResponseString.substring(0, 1000 < actualResponseLength ? 1000 : actualResponseLength)} ....');
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch [List<ValidatorModel>] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse [List<ValidatorModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of QueryValidatorsService.getValidatorsByAddresses() method', () {
    test('Should return [List of ValidatorModel] by specified addresses', () async {
      List<String> validatorAddressList = <String>[
        'kira1mpqwqe3zhejalh9zveumy3uduess5p8n09wjmh',
        'kira1wmexfgtah5yrezm9fktflfr9d29t523czqhehj',
        'kira1jss2r7q56k65tvfwe8s5xxdt0av2uvjdulh8kq,'
      ];

      TestUtils.printInfo('Data request');
      try {
        List<ValidatorModel> actualValidatorModelList = await actualQueryValidatorsService.getValidatorsByAddresses(validatorAddressList);

        TestUtils.printInfo('Data return');
        print(actualValidatorModelList);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch [List<ValidatorModel>] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse [List<ValidatorModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of QueryValidatorsService.getQueryValidatorsResp() method', () {
    test('Should return [QueryValidatorsResp] with status & waiting & validators fields', () async {
      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq(all: true);

      TestUtils.printInfo('Data request');
      try {
        QueryValidatorsResp? actualQueryValidatorsResp = await actualQueryValidatorsService.getQueryValidatorsResp(actualQueryValidatorsReq);

        TestUtils.printInfo('Data return');

        String responseString = actualQueryValidatorsResp.toString();
        int responseLength = responseString.length;

        print('${responseString.substring(0, 1000 < responseLength ? 1000 : responseLength)} ....');
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch [List<ValidatorModel>] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse [List<ValidatorModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of QueryValidatorsService.getStatus() method', () {
    test('Should return [Status] DTO', () async {
      TestUtils.printInfo('Data request');
      try {
        Status? actualStatus = await actualQueryValidatorsService.getStatus(networkUri);

        TestUtils.printInfo('Data return');
        print(actualStatus);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot fetch [Status] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Cannot parse [Status] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_validators_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
