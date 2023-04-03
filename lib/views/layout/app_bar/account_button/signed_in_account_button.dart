import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/account_drawer_page/account_drawer_page.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class SignedInAccountButton extends StatelessWidget {
  final Size size;
  final Wallet wallet;

  const SignedInAccountButton({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget signedInAccountButtonDesktop = _SignedInAccountButtonDesktop(wallet: wallet, size: size);
    Widget signedInAccountButtonMobile = _SignedInAccountButtonMobile(wallet: wallet, size: size);

    return ResponsiveWidget(
      largeScreen: signedInAccountButtonDesktop,
      mediumScreen: signedInAccountButtonDesktop,
      smallScreen: signedInAccountButtonMobile,
    );
  }
}

class _SignedInAccountButtonDesktop extends StatefulWidget {
  final Size size;
  final Wallet wallet;

  const _SignedInAccountButtonDesktop({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInAccountButtonDesktopState();
}

class _SignInAccountButtonDesktopState extends State<_SignedInAccountButtonDesktop> {
  final PopWrapperController popWrapperController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: PopWrapper(
        buttonSize: Size(widget.size.width, widget.size.height),
        popWrapperController: popWrapperController,
        popupBuilder: _buildAccountPopMenu,
        buttonBuilder: _buildButton,
      ),
    );
  }

  Widget _buildAccountPopMenu() {
    return _AccountPopMenu(
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

class _SignedInAccountButtonMobile extends StatelessWidget {
  final Size size;
  final Wallet wallet;

  const _SignedInAccountButtonMobile({
    required this.size,
    required this.wallet,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(AccountDrawerPage()),
        child: KiraIdentityAvatar(
          size: size.height,
          address: wallet.address.bech32Address,
        ),
      ),
    );
  }
}

class _AccountPopMenu extends StatelessWidget {
  final double width;
  final PopWrapperController popWrapperController;

  const _AccountPopMenu({
    required this.width,
    required this.popWrapperController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AccountMenuList(onItemTap: _onTap),
    );
  }

  void _onTap() {
    popWrapperController.hideTooltip();
  }
}
