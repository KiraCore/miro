import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_toast.dart';

class MyAccountTile extends StatelessWidget {
  final Wallet wallet;

  const MyAccountTile({
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: DesignColors.blue1_100,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: _copyPublicAddress,
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

  void _copyPublicAddress() {
    Clipboard.setData(ClipboardData(text: wallet.address.bech32Address));
    KiraToast.show('Public address copied');
  }
}
