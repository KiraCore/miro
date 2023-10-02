import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/widgets/generic/account/account_tile_layout.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:shimmer/shimmer.dart';

class AccountTile extends StatefulWidget {
  final WalletAddress walletAddress;
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
        usernameWidget: Shimmer.fromColors(
          baseColor: DesignColors.grey3,
          highlightColor: DesignColors.grey2,
          child: Container(
            width: 150,
            height: (widget.usernameTextStyle ?? textTheme.bodyText2)?.fontSize,
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
            height: (widget.addressTextStyle ?? textTheme.caption)?.fontSize,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: DesignColors.grey2,
            ),
          ),
        ),
      );
    }

    return AccountTileLayout(
      addressVisibleBool: widget.addressVisibleBool,
      avatarWidget: KiraIdentityAvatar(
        address: widget.walletAddress.bech32Address,
        avatarUrl: widget.avatarUrl,
        size: widget.size,
      ),
      usernameWidget: Text(
        widget.username ?? widget.walletAddress.buildBech32AddressShort(delimiter: '...'),
        overflow: TextOverflow.ellipsis,
        style: widget.usernameTextStyle ?? textTheme.bodyText2!.copyWith(color: DesignColors.white1),
      ),
      addressWidget: Text(
        widget.walletAddress.buildBech32AddressShort(delimiter: '...'),
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        style: widget.addressTextStyle ?? textTheme.caption!.copyWith(color: DesignColors.grey1),
      ),
    );
  }
}
