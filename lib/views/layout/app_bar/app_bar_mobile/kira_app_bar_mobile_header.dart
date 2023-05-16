import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/account_button/account_button.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop_menu_button.dart';
import 'package:miro/views/widgets/kira/kira_logo.dart';

class KiraAppBarMobileHeader extends StatelessWidget {
  final double height;

  const KiraAppBarMobileHeader({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const BackdropMenuButton(),
          const KiraLogo(height: 30),
          AccountButton(size: const Size(40, 40)),
        ],
      ),
    );
  }
}
