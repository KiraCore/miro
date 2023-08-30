enum IRRecordStatus {
  verified,
  pending,
  notVerified;

  factory IRRecordStatus.build({
    required bool hasVerifiersBool,
    required bool hasPendingVerifiersBool,
  }) {
     if (hasVerifiersBool) {
      return IRRecordStatus.verified;
    } else if (hasPendingVerifiersBool) {
       return IRRecordStatus.pending;
     } else {
      return IRRecordStatus.notVerified;
    }
  }
}
