import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters.dart';
import 'package:miro/infra/dto/api_kira/query_governance_voters/voters_permissions.dart';
import 'package:miro/infra/dto/api_kira/query_governance_votes/votes.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_governance_vote_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_governance_vote_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryGovernanceVoteService queryGovernanceVoteService = globalLocator<QueryGovernanceVoteService>();

  group('Tests of QueryGovernanceVoteService.getGovernanceVotes() method', () {
    test('Should return GovernanceVotes request if [servery HEALTHY] and [response data VALID] ', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      List<Votes> actualVotesList = await queryGovernanceVoteService.getGovernanceVotes(proposalId: 1);

      // Assert
      List<Votes> expectedVotesList = const <Votes>[
        Votes(
          proposalId: 1,
          voter: 'kira1vmwdgw426aj9fx33fqusmtg6r65yyucmx6rdt4',
          option: 'VOTE_OPTION_YES',
        )
      ];

      expect(actualVotesList, expectedVotesList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryGovernanceVoteService.getGovernanceVotes(proposalId: 1),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryGovernanceVoteService.getGovernanceVotes(proposalId: 1),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
  group('Tests of QueryGovernanceVotersService.getGovernanceVoters() method', () {
    test(
      'Should return GovernanceVoters request if [servery HEALTHY] and [response data VALID] ',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');

        // Act
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        List<Voters> actualVotersList = await queryGovernanceVoteService.getGovernanceVoters(proposalId: 1);

        // Assert
        List<Voters> expectedVotersList = <Voters>[
          const Voters(
            address: 'kira1vmwdgw426aj9fx33fqusmtg6r65yyucmx6rdt4',
            roles: <String>['1', '2'],
            status: 'ACTIVE',
            votes: <String>[
              'VOTE_OPTION_YES',
              'VOTE_OPTION_ABSTAIN',
              'VOTE_OPTION_NO',
              'VOTE_OPTION_NO_WITH_VETO',
            ],
            permissions: VotersPermissions(
              blacklist: <String>[],
              whitelist: <String>[
                'PERMISSION_CREATE_SET_PERMISSIONS_PROPOSAL',
                '',
                'PERMISSION_CREATE_UPSERT_TOKEN_ALIAS_PROPOSAL',
                'PERMISSION_CREATE_SOFTWARE_UPGRADE_PROPOSAL',
                'PERMISSION_VOTE_SET_PERMISSIONS_PROPOSAL',
                '',
                'PERMISSION_VOTE_UPSERT_TOKEN_ALIAS_PROPOSAL',
                'PERMISSION_SOFTWARE_UPGRADE_PROPOSAL'
              ],
            ),
            skin: 1,
          ),
        ];

        expect(actualVotersList, expectedVotersList);
      },
    );

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryGovernanceVoteService.getGovernanceVoters(proposalId: 1),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryGovernanceVoteService.getGovernanceVoters(proposalId: 1),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
