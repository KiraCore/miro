import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_whitelist_account_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalWhitelistAccountPermissionModel extends AProposalTypeContentModel {
  final String address;
  final String permission;

  const ProposalWhitelistAccountPermissionModel({
    required ProposalType proposalType,
    required this.address,
    required this.permission,
  }) : super(proposalType: proposalType);

  factory ProposalWhitelistAccountPermissionModel.fromDto(ProposalWhitelistAccountPermission proposalWhitelistAccountPermission) {
    return ProposalWhitelistAccountPermissionModel(
      proposalType: ProposalType.fromString(proposalWhitelistAccountPermission.type),
      address: proposalWhitelistAccountPermission.address,
      permission: proposalWhitelistAccountPermission.permission,
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
    return S.of(context).proposalTypeWhitelistAccountPermission;
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
