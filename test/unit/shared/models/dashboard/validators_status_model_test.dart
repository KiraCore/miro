import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/dashboard/consensus_state_type.dart';
import 'package:miro/shared/models/dashboard/validators_status_model.dart';

void main() {
  group('Tests of ValidatorsStatusModel consensusStateType getter', () {
    test('Should return ConsensusStateType.unhealthy if paused + inactive validators are 1/3 (or more) of all validators', () {
      // Arrange
      ValidatorsStatusModel actualValidatorsStatusModel = const ValidatorsStatusModel(
        activeValidators: 97,
        inactiveValidators: 426,
        pausedValidators: 30,
        //
        jailedValidators: 8,
        totalValidators: 561,
        waitingValidators: 419,
      );

      // Act
      ConsensusStateType actualConsensusStateType = actualValidatorsStatusModel.consensusStateType;

      // Assert
      ConsensusStateType expectedConsensusStateType = ConsensusStateType.unhealthy;

      expect(actualConsensusStateType, expectedConsensusStateType);
    });

    test('Should return ConsensusStateType.unhealthy if paused + inactive validators are 1/3 (or more) of all validators', () {
      // Arrange
      ValidatorsStatusModel actualValidatorsStatusModel = const ValidatorsStatusModel(
        activeValidators: 97,
        inactiveValidators: 30,
        pausedValidators: 426,
        //
        jailedValidators: 8,
        totalValidators: 561,
        waitingValidators: 419,
      );

      // Act
      ConsensusStateType actualConsensusStateType = actualValidatorsStatusModel.consensusStateType;

      // Assert
      ConsensusStateType expectedConsensusStateType = ConsensusStateType.unhealthy;

      expect(actualConsensusStateType, expectedConsensusStateType);
    });

    test('Should return ConsensusStateType.healthy active validators are 2/3 (or more) of all whitelisted validators', () {
      // Arrange
      ValidatorsStatusModel actualValidatorsStatusModel = const ValidatorsStatusModel(
        activeValidators: 426,
        inactiveValidators: 30,
        pausedValidators: 97,
        //
        jailedValidators: 8,
        totalValidators: 561,
        waitingValidators: 419,
      );

      // Act
      ConsensusStateType actualConsensusStateType = actualValidatorsStatusModel.consensusStateType;

      // Assert
      ConsensusStateType expectedConsensusStateType = ConsensusStateType.healthy;

      expect(actualConsensusStateType, expectedConsensusStateType);
    });
  });
}
