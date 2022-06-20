// ignore: implementation_imports
import 'package:bip39/src/wordlists/english.dart' as bip39;
import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/mnemonic_grid/editable_mnemonic_grid/mnemonic_text_field_state.dart';

class MnemonicTextFieldController {
  final int index;
  final VoidCallback afterSubmitCallback;

  final FocusNode focusNode = FocusNode();
  final ValueNotifier<String> hintNotifier = ValueNotifier<String>('');
  final ValueNotifier<MnemonicTextFieldState> mnemonicTextFieldStateNotifier =
      ValueNotifier<MnemonicTextFieldState>(MnemonicTextFieldState.normal);
  final ValueNotifier<bool> showPlaceholderNotifier = ValueNotifier<bool>(true);
  final TextEditingController textEditingController = TextEditingController();
  final ValueNotifier<bool?> validNotifier = ValueNotifier<bool?>(null);

  MnemonicTextFieldController({
    required this.index,
    required this.afterSubmitCallback,
    String? initialValue,
  }) {
    textEditingController.text = initialValue ?? '';
  }

  void handleFocusChanged() {
    if (!focusNode.hasFocus) {
      handleTextFieldSubmitted(textEditingController.text);
    } else {
      mnemonicTextFieldStateNotifier.value = _getMnemonicGridItemState();
    }
  }

  void handleTextFieldSubmitted(String value) {
    String submittedValue = value;
    if (hintNotifier.value.isNotEmpty) {
      submittedValue = hintNotifier.value;
    }
    String parsedValue = submittedValue.replaceAll(' ', '').toLowerCase();
    textEditingController.text = parsedValue;
    hintNotifier.value = '';
    validNotifier.value = _isValid(parsedValue);
    _updatePlaceholder(parsedValue);
    mnemonicTextFieldStateNotifier.value = _getMnemonicGridItemState();
    afterSubmitCallback();
  }

  void handleTextFieldChanged(String value) {
    String parsedValue = value.replaceAll(' ', '').toLowerCase();
    validNotifier.value = _hasHints(parsedValue);
    _updatePlaceholder(parsedValue);
    _updateHint(parsedValue);
    mnemonicTextFieldStateNotifier.value = _getMnemonicGridItemState();
    afterSubmitCallback();
  }

  Future<void> setError() async {
    validNotifier.value = true;
    mnemonicTextFieldStateNotifier.value = MnemonicTextFieldState.error;
  }

  MnemonicTextFieldState _getMnemonicGridItemState() {
    bool hasFocus = focusNode.hasFocus;
    if (validNotifier.value == false) {
      return MnemonicTextFieldState.error;
    } else if (hasFocus) {
      return MnemonicTextFieldState.focused;
    } else {
      return MnemonicTextFieldState.normal;
    }
  }

  bool _isValid(String value) {
    List<String> matchingWords = bip39.WORDLIST.where((String e) {
      return e.toLowerCase().startsWith(value);
    }).toList();
    if (matchingWords.length == 1 && matchingWords.first.toLowerCase() == value) {
      return true;
    } else {
      return false;
    }
  }

  void _updatePlaceholder(String value) {
    if (value.isEmpty) {
      showPlaceholderNotifier.value = true;
    } else {
      showPlaceholderNotifier.value = false;
    }
  }

  void _updateHint(String value) {
    List<String> matchingWords = bip39.WORDLIST.where((String e) {
      return e.toLowerCase().startsWith(value.toLowerCase());
    }).toList();
    if (matchingWords.isEmpty || matchingWords.length > 1) {
      hintNotifier.value = '';
    } else {
      hintNotifier.value = matchingWords.first;
    }
  }

  bool _hasHints(String value) {
    List<String> matchingWords = bip39.WORDLIST.where((String e) {
      return e.toLowerCase().startsWith(value.toLowerCase());
    }).toList();
    return matchingWords.isNotEmpty;
  }
}
