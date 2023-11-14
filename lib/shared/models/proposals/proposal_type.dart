enum ProposalType {
  setNetworkProperty,
  assignRoleToAccount,
  blacklistAccountPermission,
  blacklistRolePermission,
  createRole,
  jailCouncilor,
  msgVoteProposal,
  removeBlacklistedAccountPermission,
  removeBlacklistedRolePermission,
  removeRoleProposal,
  removeWhitelistedAccountPermission,
  removeWhitelistedRolePermission,
  resetWholeCouncilorRank,
  setPoorNetworkMessages,
  setProposalDurations,
  unassignRoleFromAccount,
  upsertDataRegistry,
  whitelistAccountPermission,
  whitelistRolePermission,
  unknown;

  factory ProposalType.fromString(String value) {
    switch (value) {
      case '/kira.gov.SetNetworkPropertyProposal':
        return ProposalType.setNetworkProperty;
      case '/kira.gov.AssignRoleToAccountProposal':
        return ProposalType.assignRoleToAccount;
      case '/kira.gov.BlacklistAccountPermissionProposal':
        return ProposalType.blacklistAccountPermission;
      case '/kira.gov.BlacklistRolePermissionProposal':
        return ProposalType.blacklistRolePermission;
      case '/kira.gov.CreateRoleProposal':
        return ProposalType.createRole;
      // '/kira.gov.ProposalJailCouncilor' is not confirmed
      case '/kira.gov.ProposalJailCouncilor':
        return ProposalType.jailCouncilor;
      case '/kira.gov.MsgVoteProposal':
        return ProposalType.msgVoteProposal;
      case '/kira.gov.RemoveBlacklistedAccountPermissionProposal':
        return ProposalType.removeBlacklistedAccountPermission;
      case '/kira.gov.RemoveBlacklistedRolePermissionProposal':
        return ProposalType.removeBlacklistedRolePermission;
      // '/kira.gov.RemoveRoleProposal' is not confirmed
      case '/kira.gov.RemoveRoleProposal':
        return ProposalType.removeRoleProposal;
      case '/kira.gov.RemoveWhitelistedAccountPermissionProposal':
        return ProposalType.removeWhitelistedAccountPermission;
      case '/kira.gov.RemoveWhitelistedRolePermissionProposal':
        return ProposalType.removeWhitelistedRolePermission;
      case '/kira.gov.ProposalResetWholeCouncilorRank':
        return ProposalType.resetWholeCouncilorRank;
      case '/kira.gov.SetPoorNetworkMessagesProposal':
        return ProposalType.setPoorNetworkMessages;
      case '/kira.gov.SetProposalDurationsProposal':
        return ProposalType.setProposalDurations;
      case '/kira.gov.UnassignRoleFromAccountProposal':
        return ProposalType.unassignRoleFromAccount;
      case '/kira.gov.UpsertDataRegistryProposal':
        return ProposalType.upsertDataRegistry;
      case '/kira.gov.WhitelistAccountPermissionProposal':
        return ProposalType.whitelistAccountPermission;
      case '/kira.gov.WhitelistRolePermissionProposal':
        return ProposalType.whitelistRolePermission;
      default:
        return ProposalType.unknown;
    }
  }
}
