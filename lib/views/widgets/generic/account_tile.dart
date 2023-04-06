import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/copy_wrapper/copy_wrapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class AccountTile extends StatefulWidget {
  final WalletAddress walletAddress;

  const AccountTile({
    required this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountTile();
}

class _AccountTile extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: KiraIdentityAvatar(
            address: widget.walletAddress.bech32Address,
            size: const ResponsiveValue<double>(
              largeScreen: 62,
              smallScreen: 48,
            ).get(context),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.walletAddress.buildBech32AddressShort(delimiter: '...'),
                overflow: TextOverflow.ellipsis,
                style: ResponsiveValue<TextStyle>(
                  largeScreen: textTheme.headline2!.copyWith(color: DesignColors.white1),
                  smallScreen: textTheme.subtitle1!.copyWith(color: DesignColors.white1),
                ).get(context),
              ),
              const ResponsiveValue<SizedBox>(
                largeScreen: SizedBox(height: 4),
                smallScreen: SizedBox(height: 8),
              ).get(context),
              CopyWrapper(
                value: widget.walletAddress.bech32Address,
                notificationText: S.of(context).toastSuccessfullyCopied,
                child: Text(
                  widget.walletAddress.bech32Address,
                  maxLines: 1,
                  softWrap: true,
                  style: ResponsiveValue<TextStyle>(
                    largeScreen: textTheme.bodyText2!.copyWith(color: DesignColors.white2),
                    smallScreen: textTheme.caption!.copyWith(color: DesignColors.white2),
                  ).get(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
