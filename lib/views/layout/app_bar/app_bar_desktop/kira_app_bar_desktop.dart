import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/app_bar/account_button/account_button.dart';
import 'package:miro/views/layout/app_bar/current_network_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class KiraAppBarDesktop extends StatelessWidget {
  final double height;

  const KiraAppBarDesktop({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: DesignColors.black,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultMobilePageMargin.left),
      child: Row(
        children: <Widget>[
          const Spacer(),
          CurrentNetworkButton(size: const Size(192, 48)),
          const SizedBox(width: 16),
          AccountButton(),
        ],
      ),
    );
  }
}
