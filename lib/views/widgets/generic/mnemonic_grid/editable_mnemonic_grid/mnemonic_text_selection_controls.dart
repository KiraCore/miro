import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/editable_mnemonic_grid_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_paste_mnemonic_action.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_paste_mnemonic_intent.dart';

class MnemonicTextSelectionControls extends MaterialTextSelectionControls {
  final int index;
  final EditableMnemonicGridController editableMnemonicGridController;

  MnemonicTextSelectionControls({
    required this.index,
    required this.editableMnemonicGridController,
  });

  @override
  Future<void> handlePaste(TextSelectionDelegate delegate) async {
    await super.handlePaste(delegate);
    await PasteMnemonicShortcutAction(
      index: index,
      editableMnemonicGridController: editableMnemonicGridController,
    ).invoke(PasteMnemonicShortcutIntent());
  }
}
