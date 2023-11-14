import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_jail_councilor.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalJailCouncilorModel extends AProposalTypeContentModel {
  // TODO(Marcin): implement proposal structure when its documented

  const ProposalJailCouncilorModel({
    required ProposalType proposalType,
  }) : super(proposalType: proposalType);

  factory ProposalJailCouncilorModel.fromDto(ProposalJailCouncilor proposalJailCouncilor) {
    return ProposalJailCouncilorModel(
      proposalType: ProposalType.fromString(proposalJailCouncilor.type),
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{};
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeCreateRole;
  }

  @override
  List<Object> get props {
    return <Object>[];
  }
}
