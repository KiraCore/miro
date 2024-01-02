import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
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
