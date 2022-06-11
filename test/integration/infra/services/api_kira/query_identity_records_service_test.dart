import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_record_resp.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/query_identity_records_by_address_resp.dart';
import 'package:miro/infra/services/api_kira/query_identity_records_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_identity_records_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final QueryIdentityRecordsService queryIdentityRecordsService = globalLocator<QueryIdentityRecordsService>();
  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');

  group('Tests of getIdentityRecord() method', () {
    test('Should return identity record by selected id', () async {
      const int recordId = 964;

      testPrint('Data request');
      QueryIdentityRecordResp queryIdentityRecordResp =
          await queryIdentityRecordsService.getQueryIdentityRecordResp(recordId, optionalNetworkUri: networkUri);

      testPrint('Data return');
      print(queryIdentityRecordResp);
      print('');
    });
  });

  group('Tests of queryIdentityRecordsByAddressService() method', () {
    test('Should return all identity records assigned to selected address', () async {
      const String address = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      testPrint('Data request');
      QueryIdentityRecordsByAddressResp queryIdentityRecordsByAddressResp = await queryIdentityRecordsService
          .getQueryIdentityRecordsByAddressResp(address, optionalNetworkUri: networkUri);

      testPrint('Data return');
      print(queryIdentityRecordsByAddressResp);
      print('');
    });
  });
}
