import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_cubit.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_state.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/mnemonic_grid/mnemonic_grid_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  // @formatter:off
  const List<String> mnemonicWordsList = <String>['require','point','property','company','tongue','busy','bench','burden','caution','gadget','knee','glance','thought','bulk','assist','month','cereal','report','quarter','tool','section','often','require','shield'];
  // @formatter:on

  group('Tests of [MnemonicGridCubit] process', () {
    test('Should return [MnemonicGridState] assigned to specified actions', () {
      // Arrange
      final MnemonicGridCubit actualMnemonicGridCubit = MnemonicGridCubit();

      // Assert
      MnemonicGridState expectedMnemonicGridState = MnemonicGridState.loading();

      TestUtils.printInfo('Should return MnemonicGridState.loading() as initial state');
      expect(actualMnemonicGridCubit.state, expectedMnemonicGridState);

      // ************************************************************************************************

      // Act
      actualMnemonicGridCubit.init(initialMnemonicGridSize: 24);

      // Assert
      int expectedMnemonicTextFieldCubitListLength = 24;

      TestUtils.printInfo('Should initialize [MnemonicGridCubit] with 24 length list of [MnemonicTextFieldCubit]');
      expect(actualMnemonicGridCubit.state.cellsCount, expectedMnemonicTextFieldCubitListLength);

      // ************************************************************************************************

      // Act
      actualMnemonicGridCubit.updateMnemonicGridSize(mnemonicGridSize: 12);

      // Assert
      expectedMnemonicTextFieldCubitListLength = 12;

      TestUtils.printInfo('Should change size of [MnemonicTextFieldCubit] list (12 objects)');
      expect(actualMnemonicGridCubit.state.cellsCount, expectedMnemonicTextFieldCubitListLength);

      // ************************************************************************************************

      // Act
      actualMnemonicGridCubit.updateMnemonicGridSize(mnemonicGridSize: 24);

      // Assert
      expectedMnemonicTextFieldCubitListLength = 24;

      TestUtils.printInfo('Should change size of [MnemonicTextFieldCubit] list (24 objects)');
      expect(actualMnemonicGridCubit.state.cellsCount, expectedMnemonicTextFieldCubitListLength);

      // ************************************************************************************************

      // Act
      Mnemonic? actualMnemonic = actualMnemonicGridCubit.buildMnemonicObject();

      // Assert
      TestUtils.printInfo('Should return null from buildMnemonicObject() method if cannot generate mnemonic');
      expect(actualMnemonic, null);

      // ************************************************************************************************

      // Act
      actualMnemonicGridCubit.insertMnemonicWords(5, <String>['require', 'point', 'property', 'company']);
      List<String> actualMnemonicWordsList = actualMnemonicGridCubit.mnemonicPhraseList;

      // Assert
      // @formatter:off
      List<String> expectedMnemonicWordList = <String>['','','','','','require','point','property','company','','','','','','','','','','','','','','',''];
      // @formatter:on

      TestUtils.printInfo('Should paste given value into specified position');
      expect(actualMnemonicWordsList, expectedMnemonicWordList);

      // ************************************************************************************************

      // Act
      actualMnemonic = actualMnemonicGridCubit.buildMnemonicObject();

      // Assert
      TestUtils.printInfo('Should return null from buildMnemonicObject() method if cannot generate mnemonic');
      expect(actualMnemonic, null);

      // ************************************************************************************************

      // Act
      actualMnemonicGridCubit.insertMnemonicWords(5, mnemonicWordsList);
      actualMnemonicWordsList = actualMnemonicGridCubit.mnemonicPhraseList;

      // Assert
      // @formatter:off
      expectedMnemonicWordList = <String>['require','point','property','company','tongue','busy','bench','burden','caution','gadget','knee','glance','thought','bulk','assist','month','cereal','report','quarter','tool','section','often','require','shield'];
      // @formatter:on

      TestUtils.printInfo('Should fill all text fields with pasted values, if pasted values count is equal text fields count');
      expect(actualMnemonicWordsList, expectedMnemonicWordList);

      // ************************************************************************************************

      // Act
      actualMnemonic = actualMnemonicGridCubit.buildMnemonicObject();

      // Assert
      Mnemonic expectedMnemonic = Mnemonic.fromArray(array: mnemonicWordsList);

      TestUtils.printInfo('Should return generated mnemonic from buildMnemonicObject()');
      expect(actualMnemonic?.array, expectedMnemonic.array);

      // ************************************************************************************************

      // Act
      actualMnemonicGridCubit.insertMnemonicWords(0, <String>['news', 'random', 'text']);
      actualMnemonicWordsList = actualMnemonicGridCubit.mnemonicPhraseList;

      // Assert
      // @formatter:off
      expectedMnemonicWordList = <String>['news','random','text','company','tongue','busy','bench','burden','caution','gadget','knee','glance','thought','bulk','assist','month','cereal','report','quarter','tool','section','often','require','shield'];
      // @formatter:on

      TestUtils.printInfo('Should overwrite text fields with pasted values, if pasted values count is less than text fields count');
      expect(actualMnemonicWordsList, expectedMnemonicWordList);
    });
  });
}
