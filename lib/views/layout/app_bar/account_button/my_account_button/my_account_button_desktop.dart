import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_pop_menu.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class MyAccountButtonDesktop extends StatefulWidget {
  final Size size;
  final Wallet wallet;

  const MyAccountButtonDesktop({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAccountButtonDesktop();
}

class _MyAccountButtonDesktop extends State<MyAccountButtonDesktop> {
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: PopWrapper(
        popWrapperController: popWrapperController,
        popupBuilder: _buildAccountPopMenu,
        buttonBuilder: _buildButton,
      ),
    );
  }

  Widget _buildAccountPopMenu() {
    return AccountPopMenu(
      popWrapperController: popWrapperController,
      width: widget.size.width,
    );
  }

  Widget _buildButton() {
    TextTheme textTheme = Theme.of(context).textTheme;

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
                widget.wallet.address.buildBech32AddressShort(delimiter: '...'),
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText1!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.wallet.address.buildBech32AddressShort(delimiter: '...'),
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2!.copyWith(
                  color: DesignColors.white2,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.arrow_drop_down,
          color: DesignColors.white1,
        ),
      ],
    );
  }
}
