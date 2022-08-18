import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/vote/vote_option.dart';

/// [MsgVote] represents the message that should be
/// used when sending tokens from one user to another one.
/// It requires to specify the address from which to send the tokens,
/// the one that should receive the tokens and the amount of tokens to send.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.gov.v1beta1.MsgVote
// TODO(dominik): missing integration test because we don't have implemented proposals YET
class MsgVote implements ITxMsg {
  /// Bech32 address of the voter.
  final String voter;

  /// Proposal ID to vote on.
  final String proposalId;

  /// Vote option.
  final VoteOption option;

  /// Public constructor.
  MsgVote({
    required this.voter,
    required this.proposalId,
    required this.option,
  });

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> response = <String, dynamic>{
      '@type': '/kira.gov.MsgVoteProposal',
      'voter': voter,
      'proposal_id': proposalId,
      'option': option.index,
    };
    return response;
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    Map<String, dynamic> response = <String, dynamic>{
      'type': 'kiraHub/MsgVoteProposal',
      'value': <String, dynamic>{
        'voter': voter,
        'proposal_id': proposalId,
        'option': option,
      },
    };
    return response;
  }
}
