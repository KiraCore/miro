import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/dashboard_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final DashboardService dashboardService = globalLocator<DashboardService>();

  group('Tests of getDashboardModel() method', () {
    test('Should return DashboardModel', () async {
      TestUtils.printInfo('Data request');
      try {
        DashboardModel actualDashboardModel = await dashboardService.getDashboardModel();

        TestUtils.printInfo('Data return');
        print(actualDashboardModel);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('dashboard_service_test.dart: Cannot fetch DashboardModel for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('dashboard_service_test.dart: Cannot parse DashboardModel for URI $networkUri: ${e}');
      }
    });
  });
}
