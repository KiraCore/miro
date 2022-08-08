import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_in_account_button.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_out_account_button.dart';
import 'package:provider/provider.dart';

const double _kDesktopButtonWidth = 180;
const double _kDesktopButtonHeight = AppSizes.kAppBarItemsHeight;

const double _kMobileButtonWidth = 40;
const double _kMobileButtonHeight = 40;

const Size _kDesktopButtonSize = Size(_kDesktopButtonWidth, _kDesktopButtonHeight);
const Size _kMobileButtonSize = Size(_kMobileButtonWidth, _kMobileButtonHeight);

class CurrentAccountButton extends StatelessWidget {
  const CurrentAccountButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (_, WalletProvider walletProvider, Widget? child) {
        final Wallet? wallet = walletProvider.currentWallet;
        if (wallet != null) {
          return SignedInAccountButton(
            wallet: wallet,
            desktopSize: _kDesktopButtonSize,
            mobileSize: _kMobileButtonSize,
          );
        }
        return const SignedOutAccountButton(
          desktopSize: _kDesktopButtonSize,
          mobileSize: _kMobileButtonSize,
        );
      },
    );
  }
}
