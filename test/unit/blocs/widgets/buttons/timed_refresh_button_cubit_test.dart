import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/buttons/timed_refresh_button/timed_refresh_button_cubit.dart';
import 'package:miro/blocs/widgets/buttons/timed_refresh_button/timed_refresh_button_state.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/buttons/timed_refresh_button_cubit_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of TimedRefreshButtonCubit process', () {
    test('Should update state with remaining time to unlock', () async {
      // Arrange
      TimedRefreshButtonCubit actualTimedRefreshButtonCubit = TimedRefreshButtonCubit();

      // Arrange
      TimedRefreshButtonState expectedTimedRefreshButtonState = const TimedRefreshButtonState(remainingUnlockTime: Duration.zero);

      TestUtils.printInfo('Should return [TimedRefreshButtonState] with [Duration.zero] as a initial state');
      expect(actualTimedRefreshButtonCubit.state, expectedTimedRefreshButtonState);

      // ****************************************************************************************************

      // Act
      DateTime expirationTime = DateTime.now().add(const Duration(seconds: 2));
      actualTimedRefreshButtonCubit.startCounting(expirationTime);

      // Assert
      expectedTimedRefreshButtonState = const TimedRefreshButtonState(remainingUnlockTime: Duration(seconds: 2));

      TestUtils.printInfo('Should return [TimedRefreshButtonState] with [Duration(seconds: 2)] as a remaining time to unlock');
      expect(actualTimedRefreshButtonCubit.state, expectedTimedRefreshButtonState);

      // ****************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(seconds: 1));

      // Assert
      expectedTimedRefreshButtonState = const TimedRefreshButtonState(remainingUnlockTime: Duration(seconds: 1));

      TestUtils.printInfo('Should return [TimedRefreshButtonState] with [Duration(seconds: 1)] as a remaining time to unlock');
      expect(actualTimedRefreshButtonCubit.state, expectedTimedRefreshButtonState);

      // ****************************************************************************************************

      // Act
      await Future<void>.delayed(const Duration(seconds: 1));

      // Assert
      expectedTimedRefreshButtonState = const TimedRefreshButtonState(remainingUnlockTime: Duration.zero);

      TestUtils.printInfo('Should return [TimedRefreshButtonState] with [Duration.zero] as a remaining time to unlock');
      expect(actualTimedRefreshButtonCubit.state, expectedTimedRefreshButtonState);
    });
  });
}
