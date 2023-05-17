import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_blacklist_account_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalBlacklistAccountPermissionModel extends AProposalTypeContentModel {
  final String address;
  final String permission;

  const ProposalBlacklistAccountPermissionModel({
    required ProposalType proposalType,
    required this.address,
    required this.permission,
  }) : super(proposalType: proposalType);

  factory ProposalBlacklistAccountPermissionModel.fromDto(ProposalBlacklistAccountPermission proposalBlacklistAccountPermission) {
    return ProposalBlacklistAccountPermissionModel(
      address: proposalBlacklistAccountPermission.address,
      permission: proposalBlacklistAccountPermission.permission,
      proposalType: ProposalType.fromString(proposalBlacklistAccountPermission.type),
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
    return S.of(context).proposalTypeBlacklistAccountPermission;
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
