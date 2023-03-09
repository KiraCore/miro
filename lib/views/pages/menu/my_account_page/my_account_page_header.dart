import 'dart:math';

import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/account_tile.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_spacer.dart';
import 'package:miro/views/widgets/generic/responsive/column_row_swapper.dart';
import 'package:miro/views/widgets/generic/responsive/desktop_expanded.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';
import 'package:miro/views/widgets/generic/responsive/sized_box_expanded.dart';

class MyAccountPageHeader extends StatelessWidget {
  final Wallet wallet;

  const MyAccountPageHeader({
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnRowSwapper(
      children: <Widget>[
        DesktopExpanded(child: AccountTile(walletAddress: wallet.address)),
        const ColumnRowSpacer(size: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBoxExpanded(
              width: 118,
              expandOn: const <ScreenSize>[
                ScreenSize.mobile,
                ScreenSize.tablet,
              ],
              child: KiraElevatedButton(
                onPressed: null,
                disabled: true,
                title: 'Pay',
                icon: Transform.rotate(
                  angle: -pi / 2,
                  child: const Icon(
                    AppIcons.arrow_up_right,
                    size: 20,
                    color: DesignColors.background,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBoxExpanded(
              width: 137,
              expandOn: const <ScreenSize>[
                ScreenSize.mobile,
                ScreenSize.tablet,
              ],
              child: KiraElevatedButton(
                onPressed: null,
                disabled: true,
                title: 'Request',
                icon: Transform.rotate(
                  angle: pi / 2,
                  child: const Icon(
                    AppIcons.arrow_up_right,
                    size: 20,
                    color: DesignColors.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
