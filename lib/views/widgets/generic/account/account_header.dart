import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/views/widgets/generic/account/account_tile_layout.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_button.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_wrapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:shimmer/shimmer.dart';

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
        usernameWidget: Shimmer.fromColors(
          baseColor: DesignColors.grey3,
          highlightColor: DesignColors.grey2,
          child: Container(
            width: 150,
            height: textTheme.bodyLarge?.fontSize,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: DesignColors.grey2,
            ),
          ),
        ),
        addressWidget: Shimmer.fromColors(
          baseColor: DesignColors.grey3,
          highlightColor: DesignColors.grey2,
          child: Container(
            width: 200,
            height: textTheme.bodyMedium?.fontSize,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: DesignColors.grey2,
            ),
          ),
        ),
      );
    } else {
      Widget addressWidget = Text(
        irModel!.walletAddress.bech32Address,
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
                address: irModel!.walletAddress.bech32Address,
                avatarUrl: irModel!.avatarIRRecordModel.value,
                size: avatarSize,
              ),
              usernameWidget: Text(
                irModel!.usernameIRRecordModel.value ?? irModel!.walletAddress.buildBech32AddressShort(delimiter: '...'),
                overflow: TextOverflow.ellipsis,
                style: ResponsiveValue<TextStyle>(
                  largeScreen: textTheme.displayMedium!.copyWith(color: DesignColors.white1),
                  smallScreen: textTheme.headlineMedium!.copyWith(color: DesignColors.white1),
                ).get(context),
              ),
              addressWidget: ResponsiveWidget.isLargeScreen(context)
                  ? CopyWrapper(
                      value: irModel!.walletAddress.bech32Address,
                      notificationText: S.of(context).toastSuccessfullyCopied,
                      child: addressWidget,
                    )
                  : addressWidget,
            ),
          ),
          SizedBox(width: gapSize),
          if (ResponsiveWidget.isLargeScreen(context) == false)
            CopyButton(
              value: irModel!.walletAddress.bech32Address,
              notificationText: S.of(context).toastPublicAddressCopied,
              size: 20,
            ),
        ],
      );
    }
  }
}
