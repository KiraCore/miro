enum IRRecordStatus {
  verified,
  pending,
  notVerified;

  factory IRRecordStatus.build({
    required bool hasVerifiersBool,
    required bool hasPendingVerifiersBool,
  }) {
    if (hasPendingVerifiersBool) {
      return IRRecordStatus.pending;
    } else if (hasVerifiersBool) {
      return IRRecordStatus.verified;
    } else {
      return IRRecordStatus.notVerified;
    }
  }
}
