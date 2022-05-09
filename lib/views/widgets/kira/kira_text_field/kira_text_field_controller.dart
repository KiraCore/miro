import 'package:flutter/material.dart';

class KiraTextFieldController {
  late String? Function() validate;
  TextEditingController textController = TextEditingController();

  String get text {
    return textController.text;
  }

  void initController({
    required String? Function() validate,
  }) {
    this.validate = validate;
  }
}
