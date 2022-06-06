import 'package:flutter/cupertino.dart';

class TokensDropdownController {
  late VoidCallback reset;

  void initController({
    required VoidCallback reset,
  }) {
    this.reset = reset;
  }
}
