import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MnemonicTextFieldHintText extends StatelessWidget {
  final TextStyle textStyle;
  final String typedText;
  final String hintText;

  const MnemonicTextFieldHintText({
    required this.textStyle,
    required this.typedText,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: typedText,
        style: textStyle.copyWith(color: Colors.transparent),
        children: <TextSpan>[
          TextSpan(
            text: hintText.toLowerCase().replaceFirst(typedText.toLowerCase(), ''),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
