import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/request/query_proposals_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_proposals_service.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_proposals_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://168.119.228.165:11000');

  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryProposalsService actualQueryProposalService = globalLocator<QueryProposalsService>();

  group('Test of QueryProposalService.getProposals() method', () {
    test('Should return List<ProposalModel> for multiple proposals', () async {
      TestUtils.printInfo('Data request');
      try {
        PageData<ProposalModel> actualProposalData = await actualQueryProposalService.getProposals(const QueryProposalsReq(
          limit: 10,
          offset: 0,
        ));

        TestUtils.printInfo('Data return');
        print(actualProposalData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_proposals_service_test.dart: Cannot fetch [List<ProposalModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_proposals_service_test.dart: Cannot parse [List<ProposalModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_proposals_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
