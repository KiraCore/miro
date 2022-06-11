import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/query_identity_record_verify_request_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/query_identity_record_verify_requests_resp.dart';
import 'package:miro/infra/services/api_kira/query_identity_verify_requests_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_identity_verify_requests_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final QueryIdentityVerifyRequestsService identityVerifyRequestsService =
      globalLocator<QueryIdentityVerifyRequestsService>();
  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');

  group('Tests of getIdentityRecordVerifyRequest() method', () {
    test('Should return verify request by selected requestId', () async {
      const String verifyRequestId = '4';

      testPrint('Data request');
      QueryIdentityRecordVerifyRequestResp queryIdentityRecordVerifyRequestResp = await identityVerifyRequestsService
          .getQueryIdentityRecordVerifyRequestResp(verifyRequestId, optionalNetworkUri: networkUri);

      testPrint('Data return');
      print(queryIdentityRecordVerifyRequestResp);
      print('');
    });
  });

  group('Tests of getIdentityRecordVerifyRequestsByApprover() method', () {
    test('Should return all verify requests assigned to selected approver address', () async {
      const String approverAddress = 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl';

      testPrint('Data request');
      QueryIdentityRecordVerifyRequestsResp queryIdentityRecordVerifyRequestsResp = await identityVerifyRequestsService
          .getQueryIdentityRecordVerifyRequestsRespByApprover(approverAddress, optionalNetworkUri: networkUri);

      testPrint('Data return');
      print(queryIdentityRecordVerifyRequestsResp);
      print('');
    });
  });

  group('Tests of getIdentityRecordVerifyRequestsByRequester() method', () {
    test('Should return all verify requests assigned to selected requester address', () async {
      const String approverAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      testPrint('Data request');
      QueryIdentityRecordVerifyRequestsResp queryIdentityRecordVerifyRequestsResp = await identityVerifyRequestsService
          .getQueryIdentityRecordVerifyRequestsRespByRequester(approverAddress, optionalNetworkUri: networkUri);

      testPrint('Data return');
      print(queryIdentityRecordVerifyRequestsResp);
      print('');
    });
  });
}
