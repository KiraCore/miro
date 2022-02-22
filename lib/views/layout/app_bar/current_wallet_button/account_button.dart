import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/current_wallet_button/account_pop_menu.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class AccountButton extends StatefulWidget {
  final Wallet wallet;
  final Color popupBackgroundColor;
  final double width;
  final double height;

  const AccountButton({
    required this.wallet,
    required this.popupBackgroundColor,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountButton();
}

class _AccountButton extends State<AccountButton> {
  PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return PopWrapper(
      buttonWidth: widget.width,
      buttonHeight: widget.height,
      popWrapperController: popWrapperController,
      popupBuilder: _buildAccountPopMenu,
      decoration: BoxDecoration(
        color: widget.popupBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      buttonBuilder: _buildButton,
    );
  }

  Widget _buildAccountPopMenu() {
    return AccountPopMenu(
      popWrapperController: popWrapperController,
      height: 130,
      width: widget.width,
      appContext: context,
    );
  }

  Widget _buildButton(AnimationController animationController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        KiraIdentityAvatar(
          address: widget.wallet.address.bech32Address,
          size: widget.height,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.wallet.address.bech32Shortcut,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  color: DesignColors.white_100,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.wallet.address.bech32Shortcut,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  color: DesignColors.gray2_100,
                ),
              ),
            ],
          ),
        ),
        RotationTransition(
          turns: Tween<double>(begin: 0.0, end: 0.5).animate(animationController),
          child: const Icon(
            Icons.arrow_drop_down,
            color: DesignColors.gray2_100,
          ),
        ),
      ],
    );
  }
}
