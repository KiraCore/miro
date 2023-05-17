import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_reset_whole_councilor_rank.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalResetWholeCouncilorRankModel extends AProposalTypeContentModel {
  final String description;
  final String proposer;

  const ProposalResetWholeCouncilorRankModel({
    required ProposalType proposalType,
    required this.description,
    required this.proposer,
  }) : super(proposalType: proposalType);

  factory ProposalResetWholeCouncilorRankModel.fromDto(ProposalResetWholeCouncilorRank proposalResetWholeCouncilorRank) {
    return ProposalResetWholeCouncilorRankModel(
      proposalType: ProposalType.fromString(proposalResetWholeCouncilorRank.type),
      description: proposalResetWholeCouncilorRank.description,
      proposer: proposalResetWholeCouncilorRank.proposer,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'description': description,
      'proposer': proposer,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeResetWholeCouncilorRank;
  }

  @override
  List<Object> get props => <Object>[description, proposer];
}
