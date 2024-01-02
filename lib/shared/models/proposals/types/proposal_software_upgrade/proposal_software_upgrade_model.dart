import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';
import 'package:miro/shared/models/proposals/types/proposal_software_upgrade/software_upgrade_resource_model.dart';

class ProposalSoftwareUpgradeModel extends AProposalTypeContentModel {
  final bool instateUpgradeBool;
  final bool rebootRequiredBool;
  final bool skipHandlerBool;
  final String maxEnrolmentDuration;
  final String memo;
  final String name;
  final String newChainId;
  final String oldChainId;
  final String rollbackChecksum;
  final String upgradeTime;
  final List<SoftwareUpgradeResourceModel> softwareUpgradeResourceModelList;

  const ProposalSoftwareUpgradeModel({
    required ProposalType proposalType,
    required this.instateUpgradeBool,
    required this.rebootRequiredBool,
    required this.skipHandlerBool,
    required this.maxEnrolmentDuration,
    required this.memo,
    required this.name,
    required this.newChainId,
    required this.oldChainId,
    required this.rollbackChecksum,
    required this.upgradeTime,
    required this.softwareUpgradeResourceModelList,
  }) : super(proposalType: proposalType);

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'instateUpgrade': instateUpgradeBool,
      'rebootRequired': rebootRequiredBool,
      'skipHandler': skipHandlerBool,
      'maxEnrolmentDuration': maxEnrolmentDuration,
      'memo': memo,
      'name': name,
      'newChainId': newChainId,
      'oldChainId': oldChainId,
      'rollbackChecksum': rollbackChecksum,
      'upgradeTime': upgradeTime,
      'softwareUpgradeResourceModelList': softwareUpgradeResourceModelList.map((SoftwareUpgradeResourceModel resource) => resource.toJson()).toList(),
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeSoftwareUpgrade;
  }

  @override
  List<Object> get props => <Object>[
        instateUpgradeBool,
        rebootRequiredBool,
        skipHandlerBool,
        maxEnrolmentDuration,
        memo,
        name,
        newChainId,
        oldChainId,
        rollbackChecksum,
        upgradeTime,
        softwareUpgradeResourceModelList,
      ];
}
