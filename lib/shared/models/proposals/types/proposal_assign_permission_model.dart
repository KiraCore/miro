import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_assign_permission.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalAssignPermissionModel extends AProposalTypeContentModel {
  final int permission;
  final String address;

  const ProposalAssignPermissionModel({
    required ProposalType proposalType,
    required this.permission,
    required this.address,
  }) : super(proposalType: proposalType);

  factory ProposalAssignPermissionModel.fromDto(ProposalAssignPermission proposalAssignPermission) {
    return ProposalAssignPermissionModel(
      proposalType: ProposalType.fromString(proposalAssignPermission.type),
      permission: proposalAssignPermission.permission,
      address: proposalAssignPermission.address,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'permission': permission,
      'address': address,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeAssignPermissions;
  }

  @override
  List<Object> get props => <Object>[permission, address];
}
