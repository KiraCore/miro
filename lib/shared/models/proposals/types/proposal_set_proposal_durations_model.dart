import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalSetProposalDurationsModel extends AProposalTypeContentModel {
  final List<String> proposalDurations;
  final List<String> typeOfProposals;

  const ProposalSetProposalDurationsModel({
    required ProposalType proposalType,
    required this.proposalDurations,
    required this.typeOfProposals,
  }) : super(proposalType: proposalType);

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'proposalDurations': proposalDurations,
      'typeOfProposals': typeOfProposals,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeSetProposalDurations;
  }

  @override
  List<Object> get props => <Object>[proposalDurations, typeOfProposals];
}
