import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/views/widgets/generic/account/account_tile_layout.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class AccountTile extends StatefulWidget {
  final AWalletAddress walletAddress;
  final bool addressVisibleBool;
  final bool loadingBool;
  final double size;
  final String? username;
  final String? avatarUrl;
  final TextStyle? usernameTextStyle;
  final TextStyle? addressTextStyle;

  const AccountTile({
    required this.walletAddress,
    this.addressVisibleBool = true,
    this.loadingBool = false,
    this.size = 38,
    this.username,
    this.avatarUrl,
    this.usernameTextStyle,
    this.addressTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountTile();
}

class _AccountTile extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (widget.loadingBool) {
      return AccountTileLayout(
        addressVisibleBool: widget.addressVisibleBool,
        avatarWidget: KiraIdentityAvatar(
          loadingBool: true,
          size: widget.size,
        ),
        usernameWidget: LoadingContainer(
          height: (widget.usernameTextStyle ?? textTheme.bodyMedium)?.fontSize,
          width: 150,
          circularBorderRadius: 5,
        ),
        addressWidget: LoadingContainer(
          height: (widget.addressTextStyle ?? textTheme.bodySmall)?.fontSize,
          width: 200,
          circularBorderRadius: 5,
        ),
      );
    }

    return AccountTileLayout(
      addressVisibleBool: widget.addressVisibleBool,
      avatarWidget: KiraIdentityAvatar(
        address: widget.walletAddress.address,
        avatarUrl: widget.avatarUrl,
        size: widget.size,
      ),
      usernameWidget: Text(
        widget.username ?? widget.walletAddress.buildShortAddress(delimiter: '...'),
        overflow: TextOverflow.ellipsis,
        style: widget.usernameTextStyle ?? textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
      ),
      addressWidget: Text(
        widget.walletAddress.buildShortAddress(delimiter: '...'),
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: widget.addressTextStyle ?? textTheme.bodySmall!.copyWith(color: DesignColors.grey1),
      ),
    );
  }
}
