import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_assign_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_assign_role_to_account.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_blacklist_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_blacklist_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_create_role.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_remove_blacklisted_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_remove_blacklisted_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_remove_whitelisted_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_remove_whitelisted_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_reset_whole_councilor_rank.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_set_poor_network_messages.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_set_proposal_durations.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_unassign_role_from_account.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_upsert_data_registry.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_upsert_token_alias.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_whitelist_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/proposal_whitelist_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/set_network_property_proposal/set_network_property.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/software%20upgrade/proposal_software_upgrade.dart';

abstract class AProposalTypeContent extends Equatable {
  final String type;

  const AProposalTypeContent({required this.type});

  @override
  List<Object?> get props => <Object?>[type];

  static AProposalTypeContent getProposalFromJson(Map<String, dynamic> json) {
    String type = json['@type'] as String;
    switch (type) {
      case '/kira.tokens.ProposalUpsertTokenAlias':
        return ProposalUpsertTokenAlias.fromJson(json);
      case '/kira.upgrade.ProposalSoftwareUpgrade':
        return ProposalSoftwareUpgrade.fromJson(json);
      case '/kira.gov.AssignPermissionProposal':
        return ProposalAssignPermission.fromJson(json);
      case '/kira.gov.UpsertDataRegistryProposal':
        return ProposalUpsertDataRegistry.fromJson(json);
      case '/kira.gov.SetNetworkPropertyProposal':
        return SetNetworkProperty.fromJson(json);
      case '/kira.gov.CreateRoleProposal':
        return ProposalCreateRole.fromJson(json);
      case '/kira.gov.BlacklistRolePermissionProposal':
        return ProposalBlacklistRolePermission.fromJson(json);
      case '/kira.gov.AssignRoleToAccountProposal':
        return ProposalAssignRoleToAccount.fromJson(json);
      case '/kira.gov.BlacklistAccountPermissionProposal':
        return ProposalBlacklistAccountPermission.fromJson(json);
      case '/kira.gov.RemoveBlacklistedAccountPermissionProposal':
        return ProposalRemoveBlacklistedAccountPermission.fromJson(json);
      case '/kira.gov.RemoveWhitelistedAccountPermissionProposal':
        return ProposalRemoveWhitelistedAccountPermission.fromJson(json);
      case '/kira.gov.UnassignRoleFromAccountProposal':
        return ProposalUnassignRoleFromAccount.fromJson(json);
      case '/kira.gov.WhitelistAccountPermissionProposal':
        return ProposalWhitelistAccountPermission.fromJson(json);
      case '/kira.gov.RemoveBlacklistedRolePermissionProposal':
        return ProposalRemoveBlacklistedRolePermission.fromJson(json);
      case '/kira.gov.RemoveWhitelistedRolePermissionProposal':
        return ProposalRemoveWhitelistedRolePermission.fromJson(json);
      case '/kira.gov.WhitelistRolePermissionProposal':
        return ProposalWhitelistRolePermission.fromJson(json);
      case '/kira.gov.SetProposalDurationsProposal':
        return ProposalSetProposalDurations.fromJson(json);
      case '/kira.gov.SetPoorNetworkMessagesProposal':
        return ProposalSetPoorNetworkMessages.fromJson(json);
      case '/kira.gov.ProposalResetWholeCouncilorRank':
        return ProposalResetWholeCouncilorRank.fromJson(json);
      default:
        throw Exception('Proposal $type not recognized');
    }
  }
}
