import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_blacklisted_account_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalRemoveBlacklistedAccountPermissionModel extends AProposalTypeContentModel {
  final String address;
  final String permission;

  const ProposalRemoveBlacklistedAccountPermissionModel({
    required ProposalType proposalType,
    required this.address,
    required this.permission,
  }) : super(proposalType: proposalType);

  factory ProposalRemoveBlacklistedAccountPermissionModel.fromDto(
      ProposalRemoveBlacklistedAccountPermission proposalRemoveBlacklistedAccountPermission) {
    return ProposalRemoveBlacklistedAccountPermissionModel(
      proposalType: ProposalType.fromString(proposalRemoveBlacklistedAccountPermission.type),
      address: proposalRemoveBlacklistedAccountPermission.address,
      permission: proposalRemoveBlacklistedAccountPermission.permission,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'address': address,
      'permission': permission,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeRemoveBlacklistedAccountPermission;
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
