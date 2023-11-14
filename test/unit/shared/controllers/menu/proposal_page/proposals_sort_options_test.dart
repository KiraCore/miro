import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_sort_options.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';
import 'package:miro/shared/models/proposals/types/proposal_upsert_data_registry_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

void main() {
  ProposalModel unknownProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xb50a9cf774ca9762558cce61d992ca1fbe7ed7d4',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'Accept this proposal, thanks',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 1,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_UNKNOWN'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '30 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel passedProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'Initial Setup From KIRA Manager',
    transactionHash: '0xc3bc56239fc153a6e9ef41b4d95a9b6a10682d63',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'Upsert this token yes',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 2,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_PASSED'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert Samolean TestCoin icon URL link"',
    attendance: '50 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel rejectedProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xf969c7d1f71c05cf009623086c2b93605b3c27dd',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 3,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_REJECTED'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '40 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel rejectedWithVetoProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xd033b16b4a2598eece41717e9395555b8f92e32a',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 4,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_REJECTED_WITH_VETO'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '45 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel pendingProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xfa84815a206b6d7adabe773af9d19ed21a4cfa21',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 5,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_PENDING'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '32 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel quorumNotReachedProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xb136376b24310133032e667b75dece9e06105265',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 6,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_QUORUM_NOT_REACHED'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '49 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel enactmentProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xb136376b24310133032e667b75dece9e06105265',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 7,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_ENACTMENT'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '31 / 50',
    votingEndTime: DateTime.parse('2023-05-25T13:06:51.893680415Z'),
  );

  ProposalModel passedWithExecFailProposalModel = ProposalModel(
    proposalTypeContentModel: const ProposalUpsertDataRegistryModel(
      proposalType: ProposalType.upsertDataRegistry,
      encoding: 'picture',
      hash: '891bd9d3b2ee0c6eed43a8129b096bebc7e5ae517d0b855b2116a3205211fe21',
      key: 'icon2',
      reference: 'https://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg',
      size: '1597',
    ),
    description: 'description',
    transactionHash: '0xf2cdd6c4e17e640fc1a2e833ef534c554f661548',
    votingEnactedTime: DateTime.parse('2023-05-25T13:11:51.893680415Z'),
    metaData: 'REF#544561324645465',
    proposer: ValidatorSimplifiedModel(
      walletAddress: WalletAddress.fromBech32('kira1rk3lc3mxqx4pj87veefmwud2seg7qrx6sz2y09'),
      moniker: 'VaMIROdator',
      logo: 'https://ipfs.kira.network/ipfs/bafybeigjtu7wkkk45c2wqu7ltaxefulpoms3lbv66utmeebgi3wihhvxrq/87e574097f6af25cb04e85a445881dc41d9a07fd.png',
    ),
    id: 8,
    quorum: '33%',
    proposalStatus: ProposalStatus.fromString('VOTE_RESULT_PASSED_WITH_EXEC_FAIL'),
    votingStartTime: DateTime.parse('2023-05-25T13:00:51.893680415Z'),
    title: 'Upsert KEX icon URL link',
    attendance: '29 / 50',
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

  group('Tests of ProposalsSortOptions.sortById', () {
    test('Should return proposalList by "id" ascending', () {
      // Act
      List<ProposalModel> actualProposalModelList = ProposalsSortOptions.sortById.sort(List<ProposalModel>.from(proposalModelList));

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

    test('Should return proposalList by "id" descending', () {
      // Act
      List<ProposalModel> actualProposalModelList = ProposalsSortOptions.sortById.reversed().sort(List<ProposalModel>.from(proposalModelList));

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
