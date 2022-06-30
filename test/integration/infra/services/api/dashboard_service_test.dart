import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/dashboard_service_test.dart --platform chrome
// ignore_for_file: avoid_print
void main() {
  group('Tests of getData() method', () {
    test('Should return dashboard data', () async {
      await initLocator();

      final DashboardService dashboardService = globalLocator<DashboardService>();
      final Uri uri = NetworkUtils.parseUrl('http://135.181.205.211:11000');

      testPrint('Data request');
      DashboardResp? dashboardResp = await dashboardService.getData(optionalNetworkUri: uri);

      testPrint('Data return');

      print(dashboardResp);
      print('');
    });
  });
}
