import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_paste_mnemonic_intent.dart';

class PasteMnemonicShortcutAction extends Action<PasteMnemonicShortcutIntent> {
  final int index;
  final EditableMnemonicGridController editableMnemonicGridController;

  PasteMnemonicShortcutAction({
    required this.index,
    required this.editableMnemonicGridController,
  }) : super();

  @override
  Future<void> invoke(PasteMnemonicShortcutIntent intent) async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData == null || clipboardData.text == null) {
      return;
    }
    String pastedValue = clipboardData.text!;
    List<String> availableDelimiters = <String>[' ', '\n', '\t', ','];
    List<List<String>> splitValues = List<List<String>>.empty(growable: true);
    for (String delimiter in availableDelimiters) {
      splitValues.add(pastedValue.split(delimiter));
    }
    List<String> mnemonicArray =
        splitValues.reduce((List<String> curr, List<String> el) => curr.length > el.length ? curr : el);
    editableMnemonicGridController.insertValues(index, mnemonicArray);
  }
}
