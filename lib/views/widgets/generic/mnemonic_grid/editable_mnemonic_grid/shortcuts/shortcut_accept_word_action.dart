import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_controller.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/shortcuts/shortcut_accept_word_intent.dart';

class AcceptWordShortcutAction extends Action<AcceptWordShortcutIntent> {
  final MnemonicTextFieldController mnemonicTextFieldController;

  AcceptWordShortcutAction({
    required this.mnemonicTextFieldController,
  }) : super();

  @override
  void invoke(AcceptWordShortcutIntent intent) {
    mnemonicTextFieldController.handleTextFieldSubmitted(mnemonicTextFieldController.hintNotifier.value);
    mnemonicTextFieldController.focusNode.nextFocus();
  }
}
