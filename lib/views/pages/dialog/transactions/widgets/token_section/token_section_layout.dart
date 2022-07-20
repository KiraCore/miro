import 'package:flutter/cupertino.dart';

class TokenSectionLayout extends StatelessWidget {
  final bool hasTransparentOverlay;
  final Widget amountTextFieldWidget;
  final Widget tokensDropdownWidget;
  final Widget notificationSectionWidget;
  final Widget denominationWidget;

  const TokenSectionLayout({
    required this.hasTransparentOverlay,
    required this.amountTextFieldWidget,
    required this.tokensDropdownWidget,
    required this.notificationSectionWidget,
    required this.denominationWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: hasTransparentOverlay ? 0.6 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: amountTextFieldWidget),
              const SizedBox(width: 14),
              Expanded(child: tokensDropdownWidget),
            ],
          ),
          const SizedBox(height: 8),
          notificationSectionWidget,
          const SizedBox(height: 14),
          denominationWidget
        ],
      ),
    );
  }
}
