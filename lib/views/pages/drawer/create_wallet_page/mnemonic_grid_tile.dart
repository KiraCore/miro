import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MnemonicGridTile extends StatelessWidget {
  final String mnemonicWord;

  const MnemonicGridTile({
    required this.mnemonicWord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(mnemonicWord);
  }
}
