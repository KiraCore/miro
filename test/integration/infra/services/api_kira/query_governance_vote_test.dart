import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters.dart';
import 'package:miro/infra/dto/api_kira/query_governance_votes/votes.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_governance_vote_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_governance_vote_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://168.119.228.165:11000/');

  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryGovernanceVoteService actualQueryGovernanceVotesService = globalLocator<QueryGovernanceVoteService>();

  group('Test of QueryGovernanceVoteService.getGovernanceVotes() method', () {
    test('Should return [VotesList] for a specific proposal', () async {
      TestUtils.printInfo('Data request');
      try {
        List<Votes> actualVotesList = await actualQueryGovernanceVotesService.getGovernanceVotes(proposalId: 1);
        TestUtils.printInfo('Data return');

        print(actualVotesList);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_governance_votes_test.dart: Cannot fetch [GovernanceVotes] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_governance_votes_test.dart: Cannot parse [GovernanceVotes] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_governance_votes_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
  group('Test of QueryGovernanceVotersService.getGovernanceVoters() method', () {
    test('Should return [VotersList] for a specific proposal', () async {
      TestUtils.printInfo('Data request');
      try {
        List<Voters> actualVotersList = await actualQueryGovernanceVotesService.getGovernanceVoters(proposalId: 1);

        TestUtils.printInfo('Data return');
        print(actualVotersList);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_governance_voters_test.dart: Cannot fetch [GovernanceVoters] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_governance_voters_test.dart: Cannot parse [GovernanceVoters] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_governance_voters_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
