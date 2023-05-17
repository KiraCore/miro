import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_unassign_role_from_account.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalUnassignRoleFromAccountModel extends AProposalTypeContentModel {
  final String address;
  final String roleIdentifier;

  const ProposalUnassignRoleFromAccountModel({
    required ProposalType proposalType,
    required this.address,
    required this.roleIdentifier,
  }) : super(proposalType: proposalType);

  factory ProposalUnassignRoleFromAccountModel.fromDto(ProposalUnassignRoleFromAccount proposalUnassignRoleFromAccount) {
    return ProposalUnassignRoleFromAccountModel(
      proposalType: ProposalType.fromString(proposalUnassignRoleFromAccount.type),
      address: proposalUnassignRoleFromAccount.address,
      roleIdentifier: proposalUnassignRoleFromAccount.roleIdentifier,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'address': address,
      'roleIdentifier': roleIdentifier,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeUnassignRoleFromAccount;
  }

  @override
  List<Object> get props => <Object>[address, roleIdentifier];
}
