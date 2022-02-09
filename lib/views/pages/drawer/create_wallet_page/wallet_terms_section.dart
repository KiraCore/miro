import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';

class WalletTermsSection extends StatefulWidget {
  final Wallet? wallet;

  const WalletTermsSection({
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WalletTermsSection();
}

class _WalletTermsSection extends State<WalletTermsSection> {
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        Row(
          children: <Widget>[
            SizedBox(
              width: 40,
              child: Checkbox(
                value: termsAccepted,
                activeColor: DesignColors.blue2_100,
                checkColor: DesignColors.gray3_100,
                onChanged: (bool? state) {
                  setState(() {
                    termsAccepted = !termsAccepted;
                  });
                },
              ),
            ),
            const Expanded(
              child: SizedBox(
                child: Text(
                  'I understand that if I loose seed phrases or private key I will loose access to account forever.',
                  style: TextStyle(
                    fontSize: 12,
                    color: DesignColors.gray2_100,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        KiraElevatedButton(
          onPressed: _onConnectWalledPressed,
          disabled: !termsAccepted,
          title: 'Connect wallet',
        ),
      ],
    );
  }

  void _onConnectWalledPressed() {
    if (widget.wallet != null) {
      globalLocator<WalletProvider>().updateWallet(widget.wallet!);
      KiraScaffold.of(context).closeEndDrawer();
    }
  }
}
