import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_whitelisted_role_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalRemoveWhitelistedRolePermissionModel extends AProposalTypeContentModel {
  final String permission;
  final String roleSid;

  const ProposalRemoveWhitelistedRolePermissionModel({
    required ProposalType proposalType,
    required this.permission,
    required this.roleSid,
  }) : super(proposalType: proposalType);

  factory ProposalRemoveWhitelistedRolePermissionModel.fromDto(
      ProposalRemoveWhitelistedRolePermission proposalRemoveWhitelistedRolePermission) {
    return ProposalRemoveWhitelistedRolePermissionModel(
      proposalType: ProposalType.fromString(proposalRemoveWhitelistedRolePermission.type),
      permission: proposalRemoveWhitelistedRolePermission.permission,
      roleSid: proposalRemoveWhitelistedRolePermission.roleSid,
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
    return S.of(context).proposalTypeRemoveWhitelistedRolePermission;
  }

  @override
  List<Object> get props => <Object>[permission, roleSid];
}
