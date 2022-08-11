import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/dashboard_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final DashboardService dashboardService = globalLocator<DashboardService>();

  group('Tests of getData() method', () {
    test('Should return dashboard data', () async {
      TestUtils.printInfo('Data request');
      try {
        DashboardResp actualDashboardResp = await dashboardService.getData();

        TestUtils.printInfo('Data return');
        print(actualDashboardResp);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('dashboard_service_test.dart: Cannot fetch DashboardResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('dashboard_service_test.dart: Cannot parse DashboardResp for URI $networkUri: ${e}');
      }
    });
  });
}
