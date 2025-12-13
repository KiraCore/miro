enum VoteResult {
  unknown('VOTE_RESULT_UNKNOWN'),
  passed('VOTE_RESULT_PASSED'),
  rejected('VOTE_RESULT_REJECTED'),
  rejectedWithVeto('VOTE_RESULT_REJECTED_WITH_VETO'),
  pending('VOTE_PENDING'),
  quorumNotReached('VOTE_RESULT_QUORUM_NOT_REACHED'),
  enactment('VOTE_RESULT_ENACTMENT'),
  passedWithExecFail('VOTE_RESULT_PASSED_WITH_EXEC_FAIL');

  final String value;
  const VoteResult(this.value);

  static VoteResult fromString(String value) {
    return VoteResult.values.firstWhere(
      (VoteResult e) => e.value == value,
      orElse: () => VoteResult.unknown,
    );
  }
}
