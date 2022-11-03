import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/account_button/current_account_button.dart';
import 'package:miro/views/layout/scaffold/backdrop/backdrop_toggle_button.dart';
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
        children: const <Widget>[
          BackdropToggleButton(),
          KiraLogo(height: 30),
          CurrentAccountButton(size: Size(40, 40)),
        ],
      ),
    );
  }
}
