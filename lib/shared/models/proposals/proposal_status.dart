enum ProposalStatus {
  enactment,
  passed,
  passedWithExecFail,
  pending,
  quorumNotReached,
  rejected,
  rejectedWithVeto,
  unknown;

  factory ProposalStatus.fromString(String value) {
    switch (value) {
      case 'VOTE_RESULT_ENACTMENT':
        return ProposalStatus.enactment;
      case 'VOTE_RESULT_PASSED':
        return ProposalStatus.passed;
      case 'VOTE_RESULT_PASSED_WITH_EXEC_FAIL':
        return ProposalStatus.passedWithExecFail;
      case 'VOTE_PENDING':
        return ProposalStatus.pending;
      case 'VOTE_RESULT_QUORUM_NOT_REACHED':
        return ProposalStatus.quorumNotReached;
      case 'VOTE_RESULT_REJECTED':
        return ProposalStatus.rejected;
      case 'VOTE_RESULT_REJECTED_WITH_VETO':
        return ProposalStatus.rejectedWithVeto;
      default:
        return ProposalStatus.unknown;
    }
  }
}
