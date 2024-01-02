import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/proposal.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_governance_proposal_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_governance_proposal_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://168.119.228.165:11000');

  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryGovernanceProposalService actualQueryGovernanceProposalService = globalLocator<QueryGovernanceProposalService>();

  group('Test of QueryGovernanceProposalService.getGovernanceProposals() method', () {
    test('Should return [ProposalList] for multiple proposals', () async {
      TestUtils.printInfo('Data request');
      try {
        List<Proposal> actualProposalList = await actualQueryGovernanceProposalService.getGovernanceProposals();

        TestUtils.printInfo('Data return');
        print(actualProposalList);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_governance_proposal_test.dart: Cannot fetch [GovernanceProposal] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_governance_proposal_test.dart: Cannot parse [GovernanceProposal] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_governance_proposal_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
