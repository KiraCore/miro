import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
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
