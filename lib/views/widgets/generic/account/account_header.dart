import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/views/widgets/generic/account/account_tile_layout.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_wrapper.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class AccountHeader extends StatelessWidget {
  final IRModel? irModel;

  const AccountHeader({
    required this.irModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double gapSize = 16;
    double avatarSize = const ResponsiveValue<double>(
      largeScreen: 62,
      smallScreen: 48,
    ).get(context);

    if (irModel == null) {
      return AccountTileLayout(
        addressVisibleBool: true,
        gapSize: gapSize,
        avatarWidget: KiraIdentityAvatar(
          loadingBool: true,
          size: avatarSize,
        ),
        usernameWidget: LoadingContainer(
          height: textTheme.bodyLarge?.fontSize,
          width: 150,
          circularBorderRadius: 5,
        ),
        addressWidget: LoadingContainer(
          height: textTheme.bodyMedium?.fontSize,
          width: 200,
          circularBorderRadius: 5,
        ),
      );
    } else {
      Widget addressWidget = Text(
        irModel!.walletAddress.address,
        softWrap: true,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.grey1),
      );

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: AccountTileLayout(
              addressVisibleBool: true,
              gapSize: gapSize,
              avatarWidget: KiraIdentityAvatar(
                address: irModel!.walletAddress.address,
                avatarUrl: irModel!.avatarIRRecordModel.value,
                size: avatarSize,
              ),
              usernameWidget: Text(
                irModel!.usernameIRRecordModel.value ?? irModel!.walletAddress.buildShortAddress(delimiter: '...'),
                overflow: TextOverflow.ellipsis,
                style: ResponsiveValue<TextStyle>(
                  largeScreen: textTheme.displayMedium!.copyWith(color: DesignColors.white1),
                  smallScreen: textTheme.headlineMedium!.copyWith(color: DesignColors.white1),
                ).get(context),
              ),
              addressWidget: ResponsiveWidget.isLargeScreen(context)
                  ? CopyWrapper(
                      value: irModel!.walletAddress.address,
                      notificationText: S.of(context).toastSuccessfullyCopied,
                      child: addressWidget,
                    )
                  : addressWidget,
            ),
          ),
          SizedBox(width: gapSize),
          if (ResponsiveWidget.isLargeScreen(context) == false)
            CopyButton(
              value: irModel!.walletAddress.address,
              notificationText: S.of(context).toastPublicAddressCopied,
              size: 20,
            ),
        ],
      );
    }
  }
}
