import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/dashboard/consensus_state_type.dart';

class ValidatorsStatusModel extends Equatable {
  final int activeValidators;
  final int pausedValidators;
  final int inactiveValidators;
  final int jailedValidators;
  final int totalValidators;
  final int waitingValidators;

  const ValidatorsStatusModel({
    required this.activeValidators,
    required this.pausedValidators,
    required this.inactiveValidators,
    required this.jailedValidators,
    required this.totalValidators,
    required this.waitingValidators,
  });

  ConsensusStateType get consensusStateType {
    int totalWhitelistedValidators = activeValidators + inactiveValidators + pausedValidators;
    double minActiveValidators = totalWhitelistedValidators * 0.67;

    if (activeValidators >= minActiveValidators) {
      return ConsensusStateType.healthy;
    } else {
      return ConsensusStateType.unhealthy;
    }
  }

  @override
  List<Object?> get props => <Object>[
        activeValidators,
        pausedValidators,
        inactiveValidators,
        jailedValidators,
        totalValidators,
        waitingValidators
      ];
}
