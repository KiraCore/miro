import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/software%20upgrade/software_upgrade_resource.dart';

class ProposalSoftwareUpgrade extends AProposalTypeContent {
  final bool instateUpgrade;
  final bool rebootRequired;
  final bool skipHandler;
  final String maxEnrolmentDuration;
  final String memo;
  final String name;
  final String newChainId;
  final String oldChainId;
  final String rollbackChecksum;
  final String upgradeTime;
  final List<SoftwareUpgradeResource> softwareUpgradeResourceList;

  const ProposalSoftwareUpgrade({
    required String type,
    required this.instateUpgrade,
    required this.rebootRequired,
    required this.skipHandler,
    required this.maxEnrolmentDuration,
    required this.memo,
    required this.name,
    required this.newChainId,
    required this.oldChainId,
    required this.rollbackChecksum,
    required this.upgradeTime,
    required this.softwareUpgradeResourceList,
  }) : super(type: type);

  factory ProposalSoftwareUpgrade.fromJson(Map<String, dynamic> json) {
    return ProposalSoftwareUpgrade(
      type: json['@type'] as String,
      instateUpgrade: json['instateUpgrade'] as bool,
      rebootRequired: json['rebootRequired'] as bool,
      skipHandler: json['skipHandler'] as bool,
      maxEnrolmentDuration: json['maxEnrolmentDuration'] as String,
      memo: json['memo'] as String,
      name: json['name'] as String,
      newChainId: json['newChainId'] as String,
      oldChainId: json['oldChainId'] as String,
      rollbackChecksum: json['rollbackChecksum'] as String,
      upgradeTime: json['upgradeTime'] as String,
      softwareUpgradeResourceList: (json['resources'] as List<dynamic>).map((dynamic e) => SoftwareUpgradeResource.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object> get props => <Object>[
        instateUpgrade,
        rebootRequired,
        skipHandler,
        maxEnrolmentDuration,
        memo,
        name,
        newChainId,
        oldChainId,
        rollbackChecksum,
        upgradeTime,
        softwareUpgradeResourceList,
      ];
}
