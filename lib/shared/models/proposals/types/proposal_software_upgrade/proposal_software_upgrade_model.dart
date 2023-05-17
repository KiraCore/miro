import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/software%20upgrade/proposal_software_upgrade.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/software%20upgrade/software_upgrade_resource.dart';
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

  factory ProposalSoftwareUpgradeModel.fromDto(ProposalSoftwareUpgrade proposalSoftwareUpgrade) {
    return ProposalSoftwareUpgradeModel(
      proposalType: ProposalType.fromString(proposalSoftwareUpgrade.type),
      instateUpgradeBool: proposalSoftwareUpgrade.instateUpgrade,
      maxEnrolmentDuration: proposalSoftwareUpgrade.maxEnrolmentDuration,
      memo: proposalSoftwareUpgrade.memo,
      name: proposalSoftwareUpgrade.name,
      newChainId: proposalSoftwareUpgrade.newChainId,
      oldChainId: proposalSoftwareUpgrade.oldChainId,
      rebootRequiredBool: proposalSoftwareUpgrade.rebootRequired,
      rollbackChecksum: proposalSoftwareUpgrade.rollbackChecksum,
      skipHandlerBool: proposalSoftwareUpgrade.skipHandler,
      softwareUpgradeResourceModelList: proposalSoftwareUpgrade.softwareUpgradeResourceList
          .map((SoftwareUpgradeResource e) => SoftwareUpgradeResourceModel(
                checksum: e.checksum,
                id: e.id,
                url: e.url,
                version: e.version,
              ))
          .toList(),
      upgradeTime: proposalSoftwareUpgrade.upgradeTime,
    );
  }

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
      'softwareUpgradeResourceModelList': softwareUpgradeResourceModelList.map((SoftwareUpgradeResourceModel softwareUpgradeResourceModel) {
        return <String, dynamic>{
          'checksum': softwareUpgradeResourceModel.checksum,
          'id': softwareUpgradeResourceModel.id,
          'url': softwareUpgradeResourceModel.url,
          'version': softwareUpgradeResourceModel.version,
        };
      }).toList(),
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
