import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/buttons/time_counter/time_counter_cubit.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/buttons/time_counter_cubit_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of TimedCounterCubit process', () {
    test('Should update state with remaining time to unlock', () async {
      // Arrange
      TimeCounterCubit actualTimeCounterCubit = TimeCounterCubit();

      // Rounding Duration values to seconds due to a chance of minor time fluctuations (for example: 3.999000s instead of 4.000000)
      int actualRemainingUnlockTime = (actualTimeCounterCubit.state.remainingUnlockTime.inMicroseconds / Duration.microsecondsPerSecond).round();

      // Arrange
      TestUtils.printInfo('Should return [TimedCounterState] with [0 seconds] as remaining unlock time');
      expect(actualRemainingUnlockTime, 0);

      // ****************************************************************************************************

      // Act
      DateTime expirationTime = DateTime.now().add(const Duration(seconds: 4));
      actualTimeCounterCubit.startCounting(expirationTime);
      actualRemainingUnlockTime = (actualTimeCounterCubit.state.remainingUnlockTime.inMicroseconds / Duration.microsecondsPerSecond).round();

      // Assert

      TestUtils.printInfo('Should return [TimedCounterState] with [4 seconds] as remaining unlock time');
      expect(actualRemainingUnlockTime, 4);

      // ****************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(seconds: 2));
      actualRemainingUnlockTime = (actualTimeCounterCubit.state.remainingUnlockTime.inMicroseconds / Duration.microsecondsPerSecond).round();

      // Assert
      TestUtils.printInfo('Should return [TimedCounterState] with [2 seconds] as remaining unlock time');
      expect(actualRemainingUnlockTime, 2);

      // ****************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(seconds: 2));
      actualRemainingUnlockTime = (actualTimeCounterCubit.state.remainingUnlockTime.inMicroseconds / Duration.microsecondsPerSecond).round();

      // Assert
      TestUtils.printInfo('Should return [TimedCounterState] with [0 seconds] as remaining unlock time');
      expect(actualRemainingUnlockTime, 0);
    });
  });
}