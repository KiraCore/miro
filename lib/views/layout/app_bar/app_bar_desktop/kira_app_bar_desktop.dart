import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/app_bar/account_button/current_account_button.dart';
import 'package:miro/views/layout/app_bar/current_network_button.dart';
import 'package:miro/views/layout/app_bar/kira_scaffold_search_bar.dart';
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
      color: DesignColors.blue1_10,
      padding: ResponsiveValue<EdgeInsets>(
        largeScreen: EdgeInsets.symmetric(horizontal: AppSizes.defaultDesktopPageMargin.left),
        mediumScreen: EdgeInsets.symmetric(horizontal: AppSizes.defaultMobilePageMargin.left),
        smallScreen: EdgeInsets.symmetric(horizontal: AppSizes.defaultMobilePageMargin.left),
      ).get(context),
      child: Row(
        children: const <Widget>[
          Expanded(child: KiraScaffoldSearchBar()),
          SizedBox(width: 40),
          CurrentNetworkButton(size: Size(192, 48)),
          SizedBox(width: 16),
          CurrentAccountButton(size: Size(180, 48)),
        ],
      ),
    );
  }
}
