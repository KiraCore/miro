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
      padding: ResponsiveValue<EdgeInsets>(
        largeScreen: EdgeInsets.symmetric(horizontal: AppSizes.defaultDesktopPageMargin.left),
        mediumScreen: EdgeInsets.symmetric(horizontal: AppSizes.defaultMobilePageMargin.left),
        smallScreen: EdgeInsets.symmetric(horizontal: AppSizes.defaultMobilePageMargin.left),
      ).get(context),
      child: Row(
        children: <Widget>[
          const Spacer(),
          const CurrentNetworkButton(size: Size(192, 48)),
          const SizedBox(width: 16),
          AccountButton(size: const Size(180, 48)),
        ],
      ),
    );
  }
}
