import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';
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
import 'package:miro/shared/models/proposals/proposal_type.dart';
import 'package:miro/shared/models/proposals/types/proposal_assign_role_to_account_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_blacklist_account_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_blacklist_role_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_create_role_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_jail_councilor_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_msg_vote_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_remove_blacklisted_account_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_remove_blacklisted_role_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_remove_role_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_remove_whitelisted_account_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_remove_whitelisted_role_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_reset_whole_councilor_rank_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_set_network_property/proposal_set_network_property_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_set_poor_network_messages_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_set_proposal_durations_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_unassign_role_from_account_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_unknown_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_upsert_data_registry_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_whitelist_account_permission_model.dart';
import 'package:miro/shared/models/proposals/types/proposal_whitelist_role_permission_model.dart';

abstract class AProposalTypeContentModel extends Equatable {
  final ProposalType proposalType;

  const AProposalTypeContentModel({required this.proposalType});

  static AProposalTypeContentModel buildFromDto(AProposalTypeContent proposalTypeContent, ProposalType proposalType) {
    switch (proposalType) {
      case ProposalType.setNetworkProperty:
        return ProposalSetNetworkPropertyModel.fromDto(proposalTypeContent as ProposalSetNetworkProperty);
      case ProposalType.assignRoleToAccount:
        return ProposalAssignRoleToAccountModel.fromDto(proposalTypeContent as ProposalAssignRoleToAccount);
      case ProposalType.blacklistAccountPermission:
        return ProposalBlacklistAccountPermissionModel.fromDto(proposalTypeContent as ProposalBlacklistAccountPermission);
      case ProposalType.blacklistRolePermission:
        return ProposalBlacklistRolePermissionModel.fromDto(proposalTypeContent as ProposalBlacklistRolePermission);
      case ProposalType.createRole:
        return ProposalCreateRoleModel.fromDto(proposalTypeContent as ProposalCreateRole);
      case ProposalType.jailCouncilor:
        return ProposalJailCouncilorModel.fromDto(proposalTypeContent as ProposalJailCouncilor);
      case ProposalType.msgVoteProposal:
        return ProposalMsgVoteModel.fromDto(proposalTypeContent as ProposalMsgVote);
      case ProposalType.removeBlacklistedAccountPermission:
        return ProposalRemoveBlacklistedAccountPermissionModel.fromDto(proposalTypeContent as ProposalRemoveBlacklistedAccountPermission);
      case ProposalType.removeBlacklistedRolePermission:
        return ProposalRemoveBlacklistedRolePermissionModel.fromDto(proposalTypeContent as ProposalRemoveBlacklistedRolePermission);
      case ProposalType.removeRoleProposal:
        return ProposalRemoveRoleModel.fromDto(proposalTypeContent as ProposalRemoveRole);
      case ProposalType.removeWhitelistedAccountPermission:
        return ProposalRemoveWhitelistedAccountPermissionModel.fromDto(proposalTypeContent as ProposalRemoveWhitelistedAccountPermission);
      case ProposalType.removeWhitelistedRolePermission:
        return ProposalRemoveWhitelistedRolePermissionModel.fromDto(proposalTypeContent as ProposalRemoveWhitelistedRolePermission);
      case ProposalType.resetWholeCouncilorRank:
        return ProposalResetWholeCouncilorRankModel.fromDto(proposalTypeContent as ProposalResetWholeCouncilorRank);
      case ProposalType.setPoorNetworkMessages:
        return ProposalSetPoorNetworkMessagesModel.fromDto(proposalTypeContent as ProposalSetPoorNetworkMessages);
      case ProposalType.setProposalDurations:
        return ProposalSetProposalDurationsModel.fromDto(proposalTypeContent as ProposalSetProposalDurations);
      case ProposalType.unassignRoleFromAccount:
        return ProposalUnassignRoleFromAccountModel.fromDto(proposalTypeContent as ProposalUnassignRoleFromAccount);
      case ProposalType.upsertDataRegistry:
        return ProposalUpsertDataRegistryModel.fromDto(proposalTypeContent as ProposalUpsertDataRegistry);
      case ProposalType.whitelistAccountPermission:
        return ProposalWhitelistAccountPermissionModel.fromDto(proposalTypeContent as ProposalWhitelistAccountPermission);
      case ProposalType.whitelistRolePermission:
        return ProposalWhitelistRolePermissionModel.fromDto(proposalTypeContent as ProposalWhitelistRolePermission);
      default:
        return ProposalUnknownModel.fromDto(proposalTypeContent as ProposalUnknown);
    }
  }

  Map<String, dynamic> getProposalContentValues();

  String getProposalTitle(BuildContext context);

  @override
  List<Object?> get props => <Object?>[proposalType];
}
