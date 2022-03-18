import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';

class AccountPopMenu extends StatefulWidget {
  final PopWrapperController popWrapperController;
  final double height;
  final double width;
  final BuildContext appContext;

  const AccountPopMenu({
    required this.popWrapperController,
    required this.height,
    required this.width,
    required this.appContext,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountPopMenu();
}

class _AccountPopMenu extends State<AccountPopMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(12),
      child: LayoutBuilder(
        builder: (_, __) => _buildPopList(),
      ),
    );
  }

  Widget _buildPopList() {
    return ListView(
      children: <Widget>[
        _buildListTile(
          onTap: _onNavigateToMyAccountPressed,
          title: const Text('My account'),
        ),
        _buildListTile(
          onTap: () {},
          title: const Text('Settings'),
        ),
        _buildListTile(
          onTap: _onLogout,
          title: const Text(
            'Log Out',
            style: TextStyle(
              color: DesignColors.red_100,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // TODO(dominik): Design change proposal. Remove or uncomment before release
        // const SizedBox(height: 10),
        // KiraOutlinedButton(
        //   onPressed: _onCreateNewWalletPressed,
        //   height: 40,
        //   title: 'Create new wallet',
        // ),
      ],
    );
  }

  Widget _buildListTile({required GestureTapCallback onTap, required Text title}) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title.data!,
            style: TextStyle(
              fontSize: 14,
              color: states.contains(MaterialState.hovered)
                  ? DesignColors.white_100
                  : title.style?.color ?? DesignColors.gray2_100,
            ),
          ),
        );
      },
    );
  }

  void _onNavigateToMyAccountPressed() {
    widget.popWrapperController.hideMenu();
    AutoRouter.of(widget.appContext).navigate(const MyAccountRoute());
  }

  void _onLogout() {
    widget.popWrapperController.hideMenu();
    globalLocator<WalletProvider>().logout(context);
    AutoRouter.of(context).replace(const DashboardRoute());
  }

// TODO(dominik): Design change proposal. Remove or uncomment before release
// void _onCreateNewWalletPressed() {
//   widget.popWrapperController.hideMenu();
//   KiraScaffold.of(widget.appContext).navigateEndDrawerRoute(const CreateWalletPage());
// }
}
