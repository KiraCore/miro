import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/blocs/widgets/mnemonic_grid/grid/mnemonic_grid_cubit.dart';
import 'package:miro/shared/utils/string_utils.dart';
import 'package:miro/views/widgets/mnemonic_grid/mnemonic_grid/mnemonic_text_field_actions/actions/paste_mnemonic_intent.dart';

class PasteMnemonicAction extends Action<PasteMnemonicIntent> {
  final int pasteIndex;
  final MnemonicGridCubit mnemonicGridCubit;

  PasteMnemonicAction({
    required this.pasteIndex,
    required this.mnemonicGridCubit,
  }) : super();

  @override
  Future<void> invoke(PasteMnemonicIntent intent) async {
    String clipboardText = await _getClipboardText();
    if (clipboardText.isEmpty) {
      return;
    }

    String? delimiter = StringUtils.findFirstDelimiter(clipboardText);
    if (delimiter == null) {
      mnemonicGridCubit.insertMnemonicWords(pasteIndex, <String>[clipboardText]);
    } else {
      mnemonicGridCubit.insertMnemonicWords(pasteIndex, clipboardText.split(delimiter));
    }
  }

  Future<String> _getClipboardText() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    bool clipboardEmptyBool = clipboardData == null || clipboardData.text == null;
    if (clipboardEmptyBool) {
      return '';
    }
    return clipboardData.text!;
  }
}
