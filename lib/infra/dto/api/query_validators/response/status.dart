class Status {
  final int activeValidators;
  final int pausedValidators;
  final int inactiveValidators;
  final int jailedValidators;
  final int totalValidators;
  final int waitingValidators;

  Status({
    required this.activeValidators,
    required this.pausedValidators,
    required this.inactiveValidators,
    required this.jailedValidators,
    required this.totalValidators,
    required this.waitingValidators,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      activeValidators: json['active_validators'] as int,
      pausedValidators: json['paused_validators'] as int,
      inactiveValidators: json['inactive_validators'] as int,
      jailedValidators: json['jailed_validators'] as int,
      totalValidators: json['total_validators'] as int,
      waitingValidators: json['waiting_validators'] as int,
    );
  }

  @override
  String toString() {
    return 'Status{activeValidators: $activeValidators, pausedValidators: $pausedValidators, '
        'inactiveValidators: $inactiveValidators, jailedValidators: $jailedValidators, '
        'totalValidators: $totalValidators, waitingValidators: $waitingValidators}';
  }
}
