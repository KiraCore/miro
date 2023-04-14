import 'package:equatable/equatable.dart';

class Validators extends Equatable {
  final int activeValidators;
  final int pausedValidators;
  final int inactiveValidators;
  final int jailedValidators;
  final int totalValidators;
  final int waitingValidators;

  const Validators({
    required this.activeValidators,
    required this.pausedValidators,
    required this.inactiveValidators,
    required this.jailedValidators,
    required this.totalValidators,
    required this.waitingValidators,
  });

  factory Validators.fromJson(Map<String, dynamic> json) {
    return Validators(
      activeValidators: json['active_validators'] as int,
      pausedValidators: json['paused_validators'] as int,
      inactiveValidators: json['inactive_validators'] as int,
      jailedValidators: json['jailed_validators'] as int,
      totalValidators: json['total_validators'] as int,
      waitingValidators: json['waiting_validators'] as int,
    );
  }

  @override
  List<Object?> get props => <Object>[activeValidators, pausedValidators, inactiveValidators, jailedValidators, totalValidators, waitingValidators];
}
