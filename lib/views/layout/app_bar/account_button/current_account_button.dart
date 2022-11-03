import 'package:flutter/material.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_in_account_button.dart';
import 'package:miro/views/layout/app_bar/account_button/signed_out_account_button.dart';
import 'package:provider/provider.dart';

class CurrentAccountButton extends StatelessWidget {
  final Size size;

  const CurrentAccountButton({
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (_, WalletProvider walletProvider, Widget? child) {
        final Wallet? wallet = walletProvider.currentWallet;
        if (wallet != null) {
          return SignedInAccountButton(wallet: wallet, size: size);
        }
        return SignedOutAccountButton(size: size);
      },
    );
  }
}
