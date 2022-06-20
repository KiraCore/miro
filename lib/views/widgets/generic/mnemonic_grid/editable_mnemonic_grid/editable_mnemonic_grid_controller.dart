import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/cryptography/bip39_extension.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_controller.dart';

class EditableMnemonicGridController {
  late int mnemonicSize;
  final Mnemonic? initialMnemonic;

  final ValueNotifier<MnemonicValidateResult> mnemonicValidateResultNotifier =
      ValueNotifier<MnemonicValidateResult>(MnemonicValidateResult.mnemonicTooShort);
  List<MnemonicTextFieldController> mnemonicTextFieldControllers =
      List<MnemonicTextFieldController>.empty(growable: true);

  EditableMnemonicGridController({
    required this.mnemonicSize,
    this.initialMnemonic,
  }) {
    _setUpMnemonicTextFieldControllers();
  }

  void insertValues(int index, List<String> values) {
    int lastPastedTextFieldIndex = index;
    for (int i = 0; i < values.length; i++) {
      int currentTextFieldIndex = i + index;
      if (currentTextFieldIndex >= mnemonicTextFieldControllers.length) {
        break;
      }
      lastPastedTextFieldIndex = currentTextFieldIndex;
      mnemonicTextFieldControllers[currentTextFieldIndex].handleTextFieldSubmitted(values[i]);
    }
    mnemonicTextFieldControllers[lastPastedTextFieldIndex].focusNode.requestFocus();
  }

  Mnemonic? save() {
    updateErrorMessage();
    if (mnemonicValidateResultNotifier.value != MnemonicValidateResult.success) {
      return null;
    }
    try {
      return Mnemonic.fromArray(array: _mnemonicArray);
    } catch (_) {
      AppLogger().log(message: 'Cannot create mnemonic');
    }
  }

  void updateErrorMessage() {
    MnemonicValidateResult mnemonicValidateResult = Bip39Extension.validateMnemonicWithMessage(
      _mnemonicArray.join(' '),
      mnemonicSize: mnemonicTextFieldControllers.length,
    );
    if (mnemonicValidateResult == MnemonicValidateResult.invalidChecksum) {
      mnemonicTextFieldControllers.last.setError();
    }
    mnemonicValidateResultNotifier.value = mnemonicValidateResult;
  }

  List<String> get _mnemonicArray {
    List<String> mnemonicArray = mnemonicTextFieldControllers
        .map((MnemonicTextFieldController controller) => controller.textEditingController.text)
        .where((String e) => e.isNotEmpty)
        .toList();
    return mnemonicArray;
  }

  void _setUpMnemonicTextFieldControllers() {
    if (mnemonicTextFieldControllers.length < mnemonicSize) {
      _createMnemonicTextFieldControllersToSize();
    } else if (mnemonicTextFieldControllers.length > mnemonicSize) {
      _removeMnemonicTextFieldControllersToSize();
    }
  }

  void _createMnemonicTextFieldControllersToSize() {
    while (mnemonicTextFieldControllers.length < mnemonicSize) {
      int index = mnemonicTextFieldControllers.length;
      String? value = initialMnemonic?.array[index];
      mnemonicTextFieldControllers.add(MnemonicTextFieldController(
        index: index,
        initialValue: value,
        afterSubmitCallback: updateErrorMessage,
      ));
    }
  }

  void _removeMnemonicTextFieldControllersToSize() {
    mnemonicTextFieldControllers = mnemonicTextFieldControllers.sublist(0, mnemonicSize);
  }
}
