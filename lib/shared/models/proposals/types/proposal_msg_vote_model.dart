import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_msg_vote.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalMsgVoteModel extends AProposalTypeContentModel {
  final String proposalId;
  final String voter;
  final String option;
  final String slash;

  const ProposalMsgVoteModel({
    required ProposalType proposalType,
    required this.proposalId,
    required this.voter,
    required this.option,
    required this.slash,
  }) : super(proposalType: proposalType);

  factory ProposalMsgVoteModel.fromDto(ProposalMsgVote proposalMsgVote) {
    return ProposalMsgVoteModel(
      proposalType: ProposalType.fromString(proposalMsgVote.type),
      proposalId: proposalMsgVote.proposalId,
      voter: proposalMsgVote.voter,
      option: proposalMsgVote.option,
      slash: proposalMsgVote.slash,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'proposal_id': proposalId,
      'voter': voter,
      'option': option,
      'slash': slash,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeCreateRole;
  }

  @override
  List<Object> get props {
    return <Object>[proposalId, voter, option, slash];
  }
}
