/// VoteOption enumerates the valid vote options for a given governance proposal.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.gov.v1beta1.VoteOption
// ignore_for_file: constant_identifier_names
enum VoteOption {
  /// Defines a no-op vote option.
  VOTE_OPTION_UNSPECIFIED,

  /// Defines a yes vote option.
  VOTE_OPTION_YES,

  /// Defines an abstain vote option.
  VOTE_OPTION_ABSTAIN,

  /// Defines a no vote option.
  VOTE_OPTION_NO,

  /// Defines a no with veto vote option.
  VOTE_OPTION_NO_WITH_VETO,
}
