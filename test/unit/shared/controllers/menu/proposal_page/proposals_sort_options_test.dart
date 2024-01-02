import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_sort_options.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';
import 'package:miro/shared/models/proposals/types/proposal_upsert_token_alias_model.dart';

void main() {
  ProposalModel unknownProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xb50a9cf774ca9762558cce61d992ca1fbe7ed7d4',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    execResult: '"executed successfully"',
    metaData: 'Accept this proposal, thanks',
    minEnactmentEndBlockHeight: '1',
    minVotingEndBlockHeight: '2',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 1,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_UNKNOWN'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 30,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel passedProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'Initial Setup From KIRA Manager',
    transactionHash: '0xc3bc56239fc153a6e9ef41b4d95a9b6a10682d63',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    execResult: '"executed successfully"',
    metaData: 'Upsert this token yes',
    minEnactmentEndBlockHeight: '3',
    minVotingEndBlockHeight: '4',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 2,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_PASSED'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert Samolean TestCoin icon URL link"',
    votersCount: 50,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel rejectedProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xf969c7d1f71c05cf009623086c2b93605b3c27dd',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    execResult: '"executed successfully"',
    metaData: 'REF#544561324645465',
    minEnactmentEndBlockHeight: '5',
    minVotingEndBlockHeight: '6',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 3,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_REJECTED'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 40,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel rejectedWithVetoProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xd033b16b4a2598eece41717e9395555b8f92e32a',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    execResult: '"executed successfully"',
    metaData: 'REF#544561324645465',
    minEnactmentEndBlockHeight: '7',
    minVotingEndBlockHeight: '8',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 4,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_REJECTED_WITH_VETO'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 45,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel pendingProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xfa84815a206b6d7adabe773af9d19ed21a4cfa21',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    execResult: '"executed successfully"',
    metaData: 'REF#544561324645465',
    minEnactmentEndBlockHeight: '9',
    minVotingEndBlockHeight: '10',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 5,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_PENDING'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 32,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel quorumNotReachedProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xb136376b24310133032e667b75dece9e06105265',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    execResult: '"executed successfully"',
    minEnactmentEndBlockHeight: '11',
    minVotingEndBlockHeight: '12',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 6,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_QUORUM_NOT_REACHED'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 49,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel enactmentProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xb136376b24310133032e667b75dece9e06105265',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    execResult: '"executed successfully"',
    metaData: 'REF#544561324645465',
    minEnactmentEndBlockHeight: '13',
    minVotingEndBlockHeight: '14',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 7,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_ENACTMENT'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 31,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel passedWithExecFailProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.upsertTokenAlias,
      decimals: 6,
      denoms: <String>['ukex'],
      icon: 'http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      symbol: 'KEX',
      name: 'KIRA',
      invalidatedBool: false,
    ),
    description: 'description',
    transactionHash: '0xf2cdd6c4e17e640fc1a2e833ef534c554f661548',
    enactmentEndTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    execResult: '"executed successfully"',
    minEnactmentEndBlockHeight: '15',
    minVotingEndBlockHeight: '16',
    proposer: '0x1351bae10fd0bf6500a437ee717a8ae79aae2a21',
    proposalId: 8,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_PASSED_WITH_EXEC_FAIL'),
    submitTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    votersCount: 29,
    votesCount: 50,
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );
  List<ProposalModel> proposalModelList = <ProposalModel>[
    unknownProposalModel,
    passedProposalModel,
    rejectedProposalModel,
    rejectedWithVetoProposalModel,
    pendingProposalModel,
    quorumNotReachedProposalModel,
    enactmentProposalModel,
    passedWithExecFailProposalModel,
  ];

  group('Tests of ProposalsSortOptions.sortByTop', () {
    test('Should return proposalList by "top" ascending', () {
      // Act
      List<ProposalModel> actualProposalModelList = ProposalsSortOptions.sortByTop.sort(List<ProposalModel>.from(proposalModelList));

      // Assert
      List<ProposalModel> expectedProposalModelList = <ProposalModel>[
        unknownProposalModel,
        passedProposalModel,
        rejectedProposalModel,
        rejectedWithVetoProposalModel,
        pendingProposalModel,
        quorumNotReachedProposalModel,
        enactmentProposalModel,
        passedWithExecFailProposalModel,
      ];

      expect(actualProposalModelList, expectedProposalModelList);
    });

    test('Should return proposalList by "top" descending', () {
      // Act
      List<ProposalModel> actualProposalModelList = ProposalsSortOptions.sortByTop.reversed().sort(List<ProposalModel>.from(proposalModelList));

      // Assert
      List<ProposalModel> expectedProposalModelList = <ProposalModel>[
        passedWithExecFailProposalModel,
        enactmentProposalModel,
        quorumNotReachedProposalModel,
        pendingProposalModel,
        rejectedWithVetoProposalModel,
        rejectedProposalModel,
        passedProposalModel,
        unknownProposalModel,
      ];

      expect(actualProposalModelList, expectedProposalModelList);
    });
  });
}
