import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/hint/mnemonic_hint_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/hint/mnemonic_hint_state.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/mnemonic_grid/mnemonic_hint_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  group('Tests of MnemonicHintCubit process', () {
    test('Should return MnemonicHintStates assigned to specified actions', () {
      // Arrange
      final MnemonicHintCubit actualMnemonicHintCubit = MnemonicHintCubit();

      // Arrange
      MnemonicHintState expectedMnemonicHintState = const MnemonicHintState.empty(placeholderVisibleBool: true);

      TestUtils.printInfo('Should return [MnemonicHintState.empty] with placeholder as initial state');
      expect(actualMnemonicHintCubit.state, expectedMnemonicHintState);

      // ************************************************************************************************

      // Act
      actualMnemonicHintCubit.updateHint(wordPattern: 'ar');

      // Assert
      expectedMnemonicHintState = const MnemonicHintState(hintText: 'ch');

      TestUtils.printInfo('Should return [MnemonicHintState] with the ending of the matching word');
      expect(actualMnemonicHintCubit.state, expectedMnemonicHintState);

      // ************************************************************************************************

      // Act
      actualMnemonicHintCubit.updateHint(wordPattern: 'arr');

      // Assert
      expectedMnemonicHintState = const MnemonicHintState(hintText: 'ange');

      TestUtils.printInfo('Should return [MnemonicHintState] with another ending of the matching word after pattern word update');
      expect(actualMnemonicHintCubit.state, expectedMnemonicHintState);

      // ************************************************************************************************

      // Act
      actualMnemonicHintCubit.clearHint(placeholderVisibleBool: false);

      // Assert
      expectedMnemonicHintState = const MnemonicHintState(hintText: '');

      TestUtils.printInfo('Should return [MnemonicHintState] with empty hint text if "placeholderVisibleBool" is false');
      expect(actualMnemonicHintCubit.state, expectedMnemonicHintState);

      // ************************************************************************************************

      // Act
      actualMnemonicHintCubit.clearHint(placeholderVisibleBool: true);

      // Assert
      expectedMnemonicHintState = const MnemonicHintState(hintText: '--------');

      TestUtils.printInfo('Should return [MnemonicHintState] with "--------" hint text if "placeholderVisibleBool" is true');
      expect(actualMnemonicHintCubit.state, expectedMnemonicHintState);
    });
  });
}
