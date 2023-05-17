import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_whitelisted_account_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalRemoveWhitelistedAccountPermissionModel extends AProposalTypeContentModel {
  final String address;
  final String permission;

  const ProposalRemoveWhitelistedAccountPermissionModel({
    required ProposalType proposalType,
    required this.address,
    required this.permission,
  }) : super(proposalType: proposalType);

  factory ProposalRemoveWhitelistedAccountPermissionModel.fromDto(
      ProposalRemoveWhitelistedAccountPermission proposalRemoveWhitelistedAccountPermission) {
    return ProposalRemoveWhitelistedAccountPermissionModel(
      permission: proposalRemoveWhitelistedAccountPermission.permission,
      proposalType: ProposalType.fromString(proposalRemoveWhitelistedAccountPermission.type),
      address: proposalRemoveWhitelistedAccountPermission.address,
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
    return S.of(context).proposalTypeRemoveWhitelistedAccountPermission;
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
