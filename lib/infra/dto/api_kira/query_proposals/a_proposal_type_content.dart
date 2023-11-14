import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_assign_role_to_account.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_blacklist_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_blacklist_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_create_role.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_jail_councilor.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_msg_vote.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_blacklisted_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_blacklisted_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_role.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_whitelisted_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_remove_whitelisted_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_reset_whole_councilor_rank.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_set_poor_network_messages.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_set_proposal_durations.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_unassign_role_from_account.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_unknown.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_upsert_data_registry.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_whitelist_account_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_whitelist_role_permission.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/set_network_property_proposal/proposal_set_network_property.dart';

abstract class AProposalTypeContent extends Equatable {
  final String type;

  const AProposalTypeContent({required this.type});

  @override
  List<Object?> get props => <Object?>[type];

  static AProposalTypeContent getProposalFromJson(Map<String, dynamic> json) {
    String type = json['@type'] as String;
    switch (type) {
      case '/kira.gov.SetNetworkPropertyProposal':
        return ProposalSetNetworkProperty.fromJson(json);
      case '/kira.gov.AssignRoleToAccountProposal':
        return ProposalAssignRoleToAccount.fromJson(json);
      case '/kira.gov.BlacklistAccountPermissionProposal':
        return ProposalBlacklistAccountPermission.fromJson(json);
      case '/kira.gov.BlacklistRolePermissionProposal':
        return ProposalBlacklistRolePermission.fromJson(json);
      case '/kira.gov.CreateRoleProposal':
        return ProposalCreateRole.fromJson(json);
      // '/kira.gov.ProposalJailCouncilor' is not confirmed
      case '/kira.gov.ProposalJailCouncilor':
        return ProposalJailCouncilor.fromJson(json);
      case '/kira.gov.MsgVoteProposal':
        return ProposalMsgVote.fromJson(json);
      case '/kira.gov.RemoveBlacklistedAccountPermissionProposal':
        return ProposalRemoveBlacklistedAccountPermission.fromJson(json);
      case '/kira.gov.RemoveBlacklistedRolePermissionProposal':
        return ProposalRemoveBlacklistedRolePermission.fromJson(json);
      // '/kira.gov.RemoveRoleProposal' is not confirmed
      case '/kira.gov.RemoveRoleProposal':
        return ProposalRemoveRole.fromJson(json);
      case '/kira.gov.RemoveWhitelistedAccountPermissionProposal':
        return ProposalRemoveWhitelistedAccountPermission.fromJson(json);
      case '/kira.gov.RemoveWhitelistedRolePermissionProposal':
        return ProposalRemoveWhitelistedRolePermission.fromJson(json);
      case '/kira.gov.ProposalResetWholeCouncilorRank':
        return ProposalResetWholeCouncilorRank.fromJson(json);
      case '/kira.gov.SetPoorNetworkMessagesProposal':
        return ProposalSetPoorNetworkMessages.fromJson(json);
      case '/kira.gov.SetProposalDurationsProposal':
        return ProposalSetProposalDurations.fromJson(json);
      case '/kira.gov.UnassignRoleFromAccountProposal':
        return ProposalUnassignRoleFromAccount.fromJson(json);
      case '/kira.gov.UpsertDataRegistryProposal':
        return ProposalUpsertDataRegistry.fromJson(json);
      case '/kira.gov.WhitelistAccountPermissionProposal':
        return ProposalWhitelistAccountPermission.fromJson(json);
      case '/kira.gov.WhitelistRolePermissionProposal':
        return ProposalWhitelistRolePermission.fromJson(json);
      default:
        return ProposalUnknown.fromJson(json);
    }
  }
}
