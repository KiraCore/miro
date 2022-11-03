import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/views/layout/app_bar/account_button/account_menu_list.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/pages/drawer/account_drawer_page/account_drawer_page.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';

class SignedInAccountButton extends StatelessWidget {
  final Wallet wallet;
  final Size size;

  const SignedInAccountButton({
    required this.wallet,
    required this.size,
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
  final Wallet wallet;
  final Size size;

  const _SignedInAccountButtonDesktop({
    required this.wallet,
    required this.size,
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
    return _AccountPopMenu(
      popWrapperController: popWrapperController,
      height: 130,
      width: widget.size.width,
      appContext: context,
    );
  }

  Widget _buildButton(AnimationController animationController) {
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
                widget.wallet.address.bech32Shortcut,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText1!.copyWith(
                  color: DesignColors.white_100,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.wallet.address.bech32Shortcut,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyText2!.copyWith(
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

class _SignedInAccountButtonMobile extends StatelessWidget {
  final Wallet wallet;
  final Size size;

  const _SignedInAccountButtonMobile({
    required this.wallet,
    required this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => KiraScaffold.of(context).navigateEndDrawerRoute(const AccountDrawerPage()),
        child: KiraIdentityAvatar(
          size: size.height,
          address: wallet.address.bech32Address,
        ),
      ),
    );
  }
}

class _AccountPopMenu extends StatelessWidget {
  final PopWrapperController popWrapperController;
  final double height;
  final double width;
  final BuildContext appContext;

  const _AccountPopMenu({
    required this.popWrapperController,
    required this.height,
    required this.width,
    required this.appContext,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(builder: (_, __) => AccountMenuList(onItemTap: _onTap)),
    );
  }

  void _onTap() {
    popWrapperController.hideMenu();
  }
}
