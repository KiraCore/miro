import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_whitelist_role_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalWhitelistRolePermissionModel extends AProposalTypeContentModel {
  final String permission;
  final String roleIdentifier;

  const ProposalWhitelistRolePermissionModel({
    required ProposalType proposalType,
    required this.permission,
    required this.roleIdentifier,
  }) : super(proposalType: proposalType);

  factory ProposalWhitelistRolePermissionModel.fromDto(ProposalWhitelistRolePermission proposalWhitelistRolePermission) {
    return ProposalWhitelistRolePermissionModel(
      permission: proposalWhitelistRolePermission.permission,
      proposalType: ProposalType.fromString(proposalWhitelistRolePermission.type),
      roleIdentifier: proposalWhitelistRolePermission.roleIdentifier,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'permission': permission,
      'roleIdentifier': roleIdentifier,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeWhitelistRolePermission;
  }

  @override
  List<Object> get props => <Object>[permission, roleIdentifier];
}
