import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list/account_menu_list.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class AccountSignedInButtonDesktop extends StatefulWidget {
  final Wallet wallet;
  final Size size;

  const AccountSignedInButtonDesktop({
    required this.wallet,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountSignedInButtonDesktop();
}

class _AccountSignedInButtonDesktop extends State<AccountSignedInButtonDesktop> {
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: PopWrapper(
        buttonWidth: widget.size.width,
        buttonHeight: widget.size.height,
        popWrapperController: popWrapperController,
        popupBuilder: _buildAccountPopMenu,
        decoration: BoxDecoration(
          color: DesignColors.blue1_10,
          borderRadius: BorderRadius.circular(8),
        ),
        buttonBuilder: _buildButton,
      ),
    );
  }

  Widget _buildAccountPopMenu() {
    return Container(
      height: 130,
      width: widget.size.width,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(12),
      child: AccountMenuList(onItemTap: popWrapperController.hideMenu),
    );
  }

  Widget _buildButton(AnimationController animationController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        KiraIdentityAvatar(
          address: widget.wallet.address.bech32Address,
          size: widget.size.height,
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
