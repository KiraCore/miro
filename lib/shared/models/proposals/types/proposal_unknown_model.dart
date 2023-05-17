import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_unknown.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalUnknownModel extends AProposalTypeContentModel {
  const ProposalUnknownModel({
    required ProposalType proposalType,
  }) : super(proposalType: proposalType);

  factory ProposalUnknownModel.fromDto(ProposalUnknown proposalUnknown) {
    return ProposalUnknownModel(
      proposalType: ProposalType.fromString(proposalUnknown.type),
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{};
  }

  @override
  String getProposalTitle(BuildContext context) {
    return 'Unknown';
  }

  @override
  List<Object> get props => <Object>[];
}
