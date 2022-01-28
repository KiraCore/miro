import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:provider/provider.dart';

class CurrentWalletButton extends StatefulWidget {
  final List<PopWrapperListItem> popWrapperItems;
  final Color popupBackgroundColor;

  const CurrentWalletButton({
    required this.popWrapperItems,
    required this.popupBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CurrentWalletButton();
}

class _CurrentWalletButton extends State<CurrentWalletButton> {
  final double _kButtonWidth = 180;

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
      builder: (_, WalletProvider networkProvider, Widget? child) {
        final Wallet? _wallet = networkProvider.currentWallet;
        if (_wallet != null) {
          return _buildSignedIn(_wallet);
        }
        return _buildSignedOut();
      },
    );
  }

  Widget _buildSignedIn(Wallet wallet) {
    return SizedBox(
      width: _kButtonWidth,
      height: 40,
      child: PopWrapper(
        menuList: widget.popWrapperItems,
        decoration: BoxDecoration(
          color: widget.popupBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        itemWidth: _kButtonWidth,
        buttonBuilder: (AnimationController animationController) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
                width: 40,
                child: KiraIdentityAvatar(
                  address: wallet.bech32Address,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      wallet.bech32Shortcut,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              RotationTransition(
                turns: Tween<double>(begin: 0.0, end: 0.5).animate(animationController),
                child: const Icon(Icons.arrow_drop_down),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSignedOut() {
    return KiraElevatedButton(
      width: _kButtonWidth,
      height: AppSizes.kAppBarItemsHeight - 5,
      onPressed: () {
        AutoRouter.of(context).navigate(const PagesRoute(children: <PageRouteInfo>[WelcomeRoute()]));
      },
      title: 'Connect a Wallet',
    );
  }
}
