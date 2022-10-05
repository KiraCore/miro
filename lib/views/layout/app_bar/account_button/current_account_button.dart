import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_in_account_button.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_out_account_button.dart';
import 'package:provider/provider.dart';

class CurrentAccountButton extends StatelessWidget {
  const CurrentAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size desktopButtonSize = const Size(180, AppSizes.appBarItemsHeight);
    Size mobileButtonSize = const Size(40, 40);

    return Consumer<WalletProvider>(
      builder: (_, WalletProvider walletProvider, Widget? child) {
        final Wallet? wallet = walletProvider.currentWallet;
        if (wallet != null) {
          return SignedInAccountButton(
            wallet: wallet,
            desktopSize: desktopButtonSize,
            mobileSize: mobileButtonSize,
          );
        }
        return SignedOutAccountButton(
          desktopSize: desktopButtonSize,
          mobileSize: mobileButtonSize,
        );
      },
    );
  }
}
