import 'package:flutter/cupertino.dart';

class AccountTileLayout extends StatelessWidget {
  final bool addressVisibleBool;
  final Widget avatarWidget;
  final Widget usernameWidget;
  final Widget addressWidget;
  final double gapSize;

  const AccountTileLayout({
    required this.addressVisibleBool,
    required this.avatarWidget,
    required this.usernameWidget,
    required this.addressWidget,
    this.gapSize = 12,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        avatarWidget,
        SizedBox(width: gapSize),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              usernameWidget,
              if (addressVisibleBool) ...<Widget>[
                const SizedBox(height: 3),
                addressWidget,
              ]
            ],
          ),
        ),
      ],
    );
  }
}
