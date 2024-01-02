import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposal/proposal.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_upsert_token_alias.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/software%20upgrade/proposal_software_upgrade.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/software%20upgrade/software_upgrade_resource.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_governance_proposal_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_governance_proposal_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print

Future<void> main() async {
  await initMockLocator();

  final QueryGovernanceProposalService queryGovernanceProposalService = globalLocator<QueryGovernanceProposalService>();

  group('Tests of QueryGovernanceProposalService.getGovernanceProposals() method', () {
    test('Should return GovernanceProposals response if [servery HEALTHY] and [response data VALID] ', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      List<Proposal> actualProposalsList = await queryGovernanceProposalService.getGovernanceProposals();

      // Assert
      List<Proposal> expectedProposalsList = <Proposal>[
        Proposal(
          content: const ProposalUpsertTokenAlias(
            type: '/kira.tokens.ProposalUpsertTokenAlias',
            decimals: 6,
            denoms: <String>['ukex'],
            icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
            invalidatedBool: false,
            name: 'KIRA',
            symbol: 'KEX',
          ),
          description: 'Initial Setup From KIRA Manager',
          enactmentEndTime: DateTime.parse('2023-05-25 13:11:51.894Z'),
          execResult: 'executed successfully',
          minEnactmentEndBlockHeight: '58',
          minVotingEndBlockHeight: '25',
          proposalId: 1,
          result: 'VOTE_RESULT_PASSED',
          submitTime: DateTime.parse('2023-05-25 13:00:51.894Z'),
          title: 'Upsert KEX icon URL link',
          votingEndTime: DateTime.parse('2023-05-25 13:06:51.894Z'),
        ),
        Proposal(
          content: const ProposalUpsertTokenAlias(
            type: '/kira.tokens.ProposalUpsertTokenAlias',
            decimals: 8,
            denoms: <String>['test'],
            icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/test.svg',
            invalidatedBool: false,
            name: 'Test TestCoin',
            symbol: 'TEST',
          ),
          description: 'Initial Setup From KIRA Manager',
          enactmentEndTime: DateTime.parse('2023-05-25 13:12:11.908Z'),
          execResult: 'executed successfully',
          minEnactmentEndBlockHeight: '60',
          minVotingEndBlockHeight: '27',
          proposalId: 2,
          result: 'VOTE_RESULT_PASSED',
          submitTime: DateTime.parse('2023-05-25 13:01:11.908Z'),
          title: 'Upsert Test TestCoin icon URL link',
          votingEndTime: DateTime.parse('2023-05-25 13:07:11.908Z'),
        ),
        Proposal(
          content: const ProposalSoftwareUpgrade(
              type: '/kira.tokens.ProposalSoftwareUpgrade',
              instateUpgrade: true,
              maxEnrolmentDuration: '666',
              memo: 'Genesis Setup Plan',
              newChainId: 'localnet-4',
              oldChainId: 'localnet-4',
              name: 'genesis',
              rebootRequired: true,
              softwareUpgradeResourceList: <SoftwareUpgradeResource>[SoftwareUpgradeResource(checksum: '', id: 'kira', url: 'https://github.com/KiraCore/kira/releases/download/v0.11.21/kira.zip', version: '')],
              rollbackChecksum: 'genesis',
              skipHandler: true,
              upgradeTime: '1685020552'),
          description: '',
          enactmentEndTime: DateTime.parse('2023-05-25 13:12:51.939Z'),
          execResult: 'executed successfully',
          minEnactmentEndBlockHeight: '64',
          minVotingEndBlockHeight: '31',
          proposalId: 4,
          result: 'VOTE_RESULT_PASSED',
          submitTime: DateTime.parse('2023-05-25 13:01:51.939Z'),
          title: '',
          votingEndTime: DateTime.parse('2023-05-25T13:07:51.939112371Z'),
        ),
      ];

      expect(actualProposalsList, expectedProposalsList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');

      // Act
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryGovernanceProposalService.getGovernanceProposals(),
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
        queryGovernanceProposalService.getGovernanceProposals,
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
