import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
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
