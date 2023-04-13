import 'package:flutter/material.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_model.dart';

class KiraTextFieldController {
  final ReloadNotifierModel validateReloadNotifierModel = ReloadNotifierModel();
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<bool> obscureTextNotifier = ValueNotifier<bool>(false);
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void reloadErrorMessage() {
    validateReloadNotifierModel.reload();
  }

  void setErrorMessage(String? errorMessage) {
    errorNotifier.value = errorMessage;
  }
}
