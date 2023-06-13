import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_p2p/request/query_p2p_req.dart';
import 'package:miro/infra/services/api/query_visualizer_service.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api/query_visualizer_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  await initMockLocator();

  final QueryVisualizerService queryVisualizerService = globalLocator<QueryVisualizerService>();

  group('Tests of QueryVisualizerService.getVisualizerNodeModelList() method', () {
    test('Should return [VisualizerModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      PageData<VisualizerNodeModel> actualVisualizerNodeModelData = await queryVisualizerService.getVisualizerNodeModelList(const QueryP2PReq(
        limit: 10,
        offset: 0,
      ));

      // Assert
      // Because we have a lot of P2P nodes, defining all objects will be inefficient.
      // Therefore, we check whether all objects were successfully parsed
      // TODO(Marcin): update number of items after using actual endpoint instead of mock response
      expect(actualVisualizerNodeModelData.listItems.length, 18);
    });

    // TODO(Marcin): uncomment these tests after using actual endpoint instead of mock response
    // test('Should return [Empty model] if [server HEALTHY] and [response data INVALID]', () async {
    //   // Arrange
    //   Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
    //   await TestUtils.setupNetworkModel(networkUri: networkUri);
    //
    //   VisualizerModel actualVisualizerModel = await queryVisualizerService.getVisualizerModel();
    //
    //   // Assert
    //   List<VisualizerNodeModel> expectedNodeModelList = const <VisualizerNodeModel>[];
    //   expect(actualVisualizerModel.nodeModelList, expectedNodeModelList);
    // });
    //
    // test('Should throw [DioConnectException] if [server OFFLINE]', () async {
    //   // Arrange
    //   Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
    //   await TestUtils.setupNetworkModel(networkUri: networkUri);
    //
    //   // Assert
    //   expect(
    //     queryVisualizerService.getVisualizerModel,
    //     throwsA(isA<DioConnectException>()),
    //   );
    // });
  });
}
