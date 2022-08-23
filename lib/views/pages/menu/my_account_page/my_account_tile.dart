import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class MyAccountTile extends StatelessWidget {
  final Wallet wallet;

  const MyAccountTile({
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 62),
      child: Row(
        children: <Widget>[
          KiraIdentityAvatar(
            address: wallet.address.bech32Address,
            size: 62,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  wallet.address.bech32Shortcut,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline2!.copyWith(
                    color: DesignColors.white_100,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    minLeadingWidth: 0,
                    title: Text(
                      wallet.address.bech32Address,
                      maxLines: 2,
                      softWrap: true,
                      style: textTheme.bodyText1!.copyWith(
                        color: DesignColors.blue1_100,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => _copyPublicAddress(context),
                      icon: const Icon(
                        AppIcons.copy,
                        color: DesignColors.gray2_100,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _copyPublicAddress(BuildContext context) {
    Clipboard.setData(ClipboardData(text: wallet.address.bech32Address));
    KiraToast.of(context).show(
      type: ToastType.success,
      message: 'Public address copied',
    );
  }
}
