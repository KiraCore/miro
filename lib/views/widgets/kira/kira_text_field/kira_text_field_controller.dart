import 'package:flutter/material.dart';

class KiraTextFieldController {
  late String? Function() validate;
  late TextEditingController textController;

  void initController({
    required String? Function() validate,
    required TextEditingController textController,
  }) {
    this.validate = validate;
    this.textController = textController;
  }
}
