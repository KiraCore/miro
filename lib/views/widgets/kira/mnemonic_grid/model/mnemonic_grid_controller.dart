import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MnemonicGridController {
  // TODO(dominik): Check if working on other platforms
  static LogicalKeySet pasteKeySetWindows = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyV,
  );

  late Future<void> Function() paste;
  late void Function() clear;
  late List<String> Function() getValues;

  void initController({
    required Future<void> Function() paste,
    required void Function() clear,
    required List<String> Function() getValues,
  }) {
    this.paste = paste;
    this.clear = clear;
    this.getValues = getValues;
  }
}
