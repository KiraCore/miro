enum ProposalType {
  assignPermission,
  assignRoleToAccount,
  blacklistRolePermission,
  createRole,
  removeBlacklistedAccountPermission,
  removeBlacklistedRolePermission,
  removeWhitelistedAccountPermission,
  removeWhitelistedRolePermission,
  resetWholeCouncilorRank,
  setNetworkProperty,
  setPoorNetworkMessages,
  setProposalDurations,
  softwareUpgrade,
  unassignRoleFromAccount,
  unknown,
  upsertDataRegistry,
  upsertTokenAlias,
  whitelistAccountPermission,
  whitelistRolePermission;

  factory ProposalType.fromString(String value) {
    switch (value) {
      case '/kira.gov.AssignPermissionProposal':
        return ProposalType.assignPermission;
      case '/kira.gov.AssignRoleToAccountProposal':
        return ProposalType.assignRoleToAccount;
      case '/kira.gov.BlacklistRolePermissionProposal':
        return ProposalType.blacklistRolePermission;
      case '/kira.gov.CreateRoleProposal':
        return ProposalType.createRole;
      case '/kira.gov.RemoveBlacklistedAccountPermissionProposal':
        return ProposalType.removeBlacklistedAccountPermission;
      case '/kira.gov.RemoveBlacklistedRolePermissionProposal':
        return ProposalType.removeBlacklistedRolePermission;
      case '/kira.gov.RemoveWhitelistedAccountPermissionProposal':
        return ProposalType.removeWhitelistedAccountPermission;
      case '/kira.gov.RemoveWhitelistedRolePermissionProposal':
        return ProposalType.removeWhitelistedRolePermission;
      case '/kira.gov.ProposalResetWholeCouncilorRank':
        return ProposalType.resetWholeCouncilorRank;
      case '/kira.gov.SetNetworkPropertyProposal':
        return ProposalType.setNetworkProperty;
      case '/kira.gov.SetPoorNetworkMessagesProposal':
        return ProposalType.setPoorNetworkMessages;
      case '/kira.gov.SetProposalDurationsProposal':
        return ProposalType.setProposalDurations;
      case '/kira.tokens.ProposalUpsertTokenAlias':
        return ProposalType.upsertTokenAlias;
      case '/kira.upgrade.ProposalSoftwareUpgrade':
        return ProposalType.softwareUpgrade;
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
