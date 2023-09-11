import 'package:flutter/cupertino.dart';

class MnemonicTextFieldLayer extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Widget mainWidget;
  final Widget? prefixWidget;

  const MnemonicTextFieldLayer({
    required this.backgroundColor,
    required this.borderColor,
    required this.mainWidget,
    this.prefixWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 20, child: Align(alignment: Alignment.centerLeft, child: prefixWidget)),
              const SizedBox(width: 8),
              Expanded(child: Align(alignment: Alignment.centerLeft, child: mainWidget)),
            ],
          ),
        ),
      ),
    );
  }
}
