import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_approver_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/network/block_time_wrapper_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/identity_records_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final IdentityRecordsService actualIdentityRecordsService = globalLocator<IdentityRecordsService>();
  final WalletAddress actualWalletAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');

  group('Tests of IdentityRecordsService.getIdentityRecordsByAddress() method [GET in HTTP]', () {
    test('Should return [IRModel] with all identity records assigned to selected address', () async {
      TestUtils.printInfo('Data request');
      try {
        BlockTimeWrapperModel<IRModel> actualWrappedIRModel = await actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress);
        IRModel actualIRModel = actualWrappedIRModel.model;

        TestUtils.printInfo('Data return');
        print(actualIRModel);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Cannot fetch [IRModel] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Cannot parse [IRModel] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of IdentityRecordsService.getInboundVerificationRequests() method [GET in HTTP]', () {
    test('Should return [PageData<IRInboundVerificationRequestModel>] with all verifications waiting for approval', () async {
      TestUtils.printInfo('Data request');
      try {
        PageData<IRInboundVerificationRequestModel> actualVerificationRequestsPageData = await actualIdentityRecordsService.getInboundVerificationRequests(
          QueryIdentityRecordVerifyRequestsByApproverReq(
            address: actualWalletAddress.bech32Address,
            offset: 0,
            limit: 10,
          ),
        );

        TestUtils.printInfo('Data return');
        print(actualVerificationRequestsPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError(
            'identity_records_service_test.dart: Cannot fetch [PageData<IRInboundVerificationRequestModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Cannot parse [PageData<IRInboundVerificationRequestModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of IdentityRecordsService.getOutboundRecordVerificationRequests() method [GET in HTTP]', () {
    test('Should return [List of IRRecordVerificationRequestModel] with all verifiers that confirmed record', () async {
      TestUtils.printInfo('Data request');
      try {
        IRRecordModel actualIRRecordModel = const IRRecordModel.empty(key: 'username');
        List<IRRecordVerificationRequestModel> actualIrRecordVerificationRequestModels =
            await actualIdentityRecordsService.getOutboundRecordVerificationRequests(actualIRRecordModel);

        TestUtils.printInfo('Data return');
        print(actualIrRecordVerificationRequestModels);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError(
            'identity_records_service_test.dart: Cannot fetch [List of IRRecordVerificationRequestModel] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Cannot parse [List of IRRecordVerificationRequestModel] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('identity_records_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
