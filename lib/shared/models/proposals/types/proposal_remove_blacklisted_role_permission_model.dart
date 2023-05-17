import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_blacklisted_role_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalRemoveBlacklistedRolePermissionModel extends AProposalTypeContentModel {
  final String permission;
  final String roleSid;

  const ProposalRemoveBlacklistedRolePermissionModel({
    required ProposalType proposalType,
    required this.permission,
    required this.roleSid,
  }) : super(proposalType: proposalType);

  factory ProposalRemoveBlacklistedRolePermissionModel.fromDto(ProposalRemoveBlacklistedRolePermission proposalRemoveBlacklistedRolePermission) {
    return ProposalRemoveBlacklistedRolePermissionModel(
      proposalType: ProposalType.fromString(proposalRemoveBlacklistedRolePermission.type),
      permission: proposalRemoveBlacklistedRolePermission.permission,
      roleSid: proposalRemoveBlacklistedRolePermission.roleSid,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'permission': permission,
      'roleSid': roleSid,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeRemoveBlacklistedRolePermission;
  }

  @override
  List<Object> get props => <Object>[permission, roleSid];
}
