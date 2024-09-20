import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/text_field/mnemonic_text_field_state.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic_text_field_status.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/mnemonic_grid/mnemonic_text_field_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  group('Tests of MnemonicTextFieldCubit process', () {
    test('Should return [MnemonicTextFieldState] assigned to specified actions', () async {
      // Arrange
      final MnemonicGridCubit mnemonicGridCubit = MnemonicGridCubit()..updateMnemonicGridSize(mnemonicGridSize: 24);
      final MnemonicTextFieldCubit actualMnemonicTextFieldCubit = MnemonicTextFieldCubit(index: 0, mnemonicGridCubit: mnemonicGridCubit);

      // Assert
      MnemonicTextFieldState expectedMnemonicTextFieldState = const MnemonicTextFieldState.empty();

      TestUtils.printInfo('Should return [MnemonicTextFieldState.empty] as initial state');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // Assert
      String expectedMnemonicText = '';

      TestUtils.printInfo('Should return [empty string] as initial mnemonic text');
      expect(actualMnemonicTextFieldCubit.textEditingController.text, expectedMnemonicText);

      // ************************************************************************************************

      // Act
      // simulate typing letter into a MnemonicTextField
      actualMnemonicTextFieldCubit.changeFocus(textFieldFocusedBool: true);
      actualMnemonicTextFieldCubit.textEditingController.text = 'r';

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState(
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.focused,
        mnemonicText: 'r',
      );

      TestUtils.printInfo('Should return [MnemonicTextFieldState] with [FOCUSED status] and "r" text value');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // ************************************************************************************************

      // Act
      actualMnemonicTextFieldCubit
        ..acceptHint()
        ..changeFocus(textFieldFocusedBool: false);

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState(
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.valid,
        mnemonicText: 'rabbit',
      );

      TestUtils.printInfo('Should return [MnemonicTextFieldState] with [VALID status] and "rabbit" text value after accepting existing hint');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // ************************************************************************************************

      // Act
      // simulate typing letter into a MnemonicTextField
      actualMnemonicTextFieldCubit.changeFocus(textFieldFocusedBool: true);
      actualMnemonicTextFieldCubit.textEditingController.text = 'r';

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState(
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.focused,
        mnemonicText: 'r',
      );

      TestUtils.printInfo('Should return [MnemonicTextFieldState] with [FOCUSED status] and "r" text value');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // ************************************************************************************************

      // Act
      actualMnemonicTextFieldCubit.changeFocus(textFieldFocusedBool: false);

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState(
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.error,
        mnemonicText: 'r',
      );

      TestUtils.printInfo('Should return [MnemonicTextFieldState] with [ERROR status] and "r" text value after unfocus without accepting existing hint');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // ************************************************************************************************

      // Act
      actualMnemonicTextFieldCubit
        ..setValue('aaaaaaaa')
        ..changeFocus(textFieldFocusedBool: false);

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState(
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.error,
        mnemonicText: 'aaaaaaaa',
      );

      TestUtils.printInfo('Should return [MnemonicTextFieldState] with [ERROR status] and "aaaaaaaa" text value (word does not exist)');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // ************************************************************************************************

      // Act
      actualMnemonicTextFieldCubit.clear();

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState.empty();

      TestUtils.printInfo('Should return [MnemonicTextFieldState.empty] after clearing text field');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);

      // ************************************************************************************************

      // Act
      actualMnemonicTextFieldCubit.setErrorStatus();

      // Assert
      expectedMnemonicTextFieldState = const MnemonicTextFieldState(
        mnemonicTextFieldStatus: MnemonicTextFieldStatus.error,
        mnemonicText: '',
      );

      TestUtils.printInfo('Should return [MnemonicTextFieldState] with [ERROR status] if manually set error status (checksum invalid)');
      expect(actualMnemonicTextFieldCubit.state, expectedMnemonicTextFieldState);
    });
  });
}
