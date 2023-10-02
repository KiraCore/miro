import 'package:flutter/cupertino.dart';

class VerificationRequestListItemDesktopLayout extends StatelessWidget {
  final Widget infoButtonWidget;
  final Widget requesterAddressWidget;
  final Widget dateWidget;
  final Widget keysWidget;
  final Widget tipWidget;
  final double? height;

  const VerificationRequestListItemDesktopLayout({
    required this.infoButtonWidget,
    required this.requesterAddressWidget,
    required this.dateWidget,
    required this.keysWidget,
    required this.tipWidget,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double verticalPadding = height == null ? 20 : 0;
    return Container(
      height: height,
      padding: EdgeInsets.only(right: 20, top: verticalPadding, bottom: verticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Center(
              child: infoButtonWidget,
            ),
          ),
          Expanded(flex: 3, child: requesterAddressWidget),
          const Spacer(flex: 1),
          SizedBox(width: 150, child: dateWidget),
          const Spacer(flex: 1),
          Expanded(flex: 3, child: keysWidget),
          const Spacer(flex: 1),
          Expanded(flex: 3, child: tipWidget),
        ],
      ),
    );
  }
}
