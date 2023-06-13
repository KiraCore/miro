import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_p2p/request/query_p2p_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_visualizer_service.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_visualizer_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryVisualizerService actualQueryVisualizerService = globalLocator<QueryVisualizerService>();

  group('Tests of QueryVisualizerService.getVisualizerNodeModelList() method', () {
    test('Should return [VisualizerModel]', () async {
      TestUtils.printInfo('Data request');
      try {
        PageData<VisualizerNodeModel> actualVisualizerNodeModelData = await actualQueryVisualizerService.getVisualizerNodeModelList(const QueryP2PReq(
          limit: 10,
          offset: 0,
        ));

        TestUtils.printInfo('Data return');
        String actualResponseString = actualVisualizerNodeModelData.toString();
        int actualResponseLength = actualResponseString.length;

        print('${actualResponseString.substring(0, 1000 < actualResponseLength ? 1000 : actualResponseLength)} ....');
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_visualizer_service_test.dart: Cannot fetch [VisualizerModel] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_visualizer_service_test.dart: Cannot parse [VisualizerModel] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_visualizer_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
