import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_role.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalRemoveRoleModel extends AProposalTypeContentModel {
  // TODO(Marcin): implement proposal structure when its documented

  const ProposalRemoveRoleModel({
    required ProposalType proposalType,
  }) : super(proposalType: proposalType);

  factory ProposalRemoveRoleModel.fromDto(ProposalRemoveRole proposalRemoveRole) {
    return ProposalRemoveRoleModel(
      proposalType: ProposalType.fromString(proposalRemoveRole.type),
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
