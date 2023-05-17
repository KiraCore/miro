import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_assign_role_to_account.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalAssignRoleToAccountModel extends AProposalTypeContentModel {
  final String address;
  final String roleIdentifier;

  const ProposalAssignRoleToAccountModel({
    required ProposalType proposalType,
    required this.address,
    required this.roleIdentifier,
  }) : super(proposalType: proposalType);

  factory ProposalAssignRoleToAccountModel.fromDto(ProposalAssignRoleToAccount proposalAssignRoleToAccount) {
    return ProposalAssignRoleToAccountModel(
      proposalType: ProposalType.fromString(proposalAssignRoleToAccount.type),
      address: proposalAssignRoleToAccount.address,
      roleIdentifier: proposalAssignRoleToAccount.roleIdentifier,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'roleDescription': address,
      'rolesId': roleIdentifier,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeAssignRoleToAccount;
  }

  @override
  List<Object> get props => <Object>[address, roleIdentifier];
}
