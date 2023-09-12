enum StakingPoolStatus {
  withdraw,
  enabled,
  disabled;

  factory StakingPoolStatus.fromString(String? value) {
    switch (value) {
      case 'WITHDRAW':
        return StakingPoolStatus.withdraw;
      case 'ENABLED':
        return StakingPoolStatus.enabled;
      case 'DISABLED':
      default:
        return StakingPoolStatus.disabled;
    }
  }
}
