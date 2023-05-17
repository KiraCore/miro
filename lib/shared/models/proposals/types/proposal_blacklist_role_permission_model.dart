import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_blacklist_role_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalBlacklistRolePermissionModel extends AProposalTypeContentModel {
  final String permission;
  final String roleIdentifier;

  const ProposalBlacklistRolePermissionModel({
    required ProposalType proposalType,
    required this.permission,
    required this.roleIdentifier,
  }) : super(proposalType: proposalType);

  factory ProposalBlacklistRolePermissionModel.fromDto(ProposalBlacklistRolePermission proposalBlacklistRolePermission) {
    return ProposalBlacklistRolePermissionModel(
      proposalType: ProposalType.fromString(proposalBlacklistRolePermission.type),
      permission: proposalBlacklistRolePermission.permission,
      roleIdentifier: proposalBlacklistRolePermission.roleIdentifier,
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
    return S.of(context).proposalTypeBlacklistRolePermission;
  }

  @override
  List<Object> get props => <Object>[permission, roleIdentifier];
}
