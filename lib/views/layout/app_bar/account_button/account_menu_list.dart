import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class AccountMenuList extends StatelessWidget {
  final VoidCallback? onItemTap;

  const AccountMenuList({
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _MenuListTile(
          onTap: () => _onNavigateToMyAccountPressed(context),
          title: const Text('My account'),
        ),
        _MenuListTile(
          onTap: () {},
          title: const Text('Settings'),
        ),
        _MenuListTile(
          onTap: () => _onLogout(context),
          title: const Text(
            'Log Out',
            style: TextStyle(
              color: DesignColors.red_100,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  void _onNavigateToMyAccountPressed(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    AutoRouter.of(context).navigate(const MyAccountRoute());
  }

  void _onLogout(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    globalLocator<WalletProvider>().logout(context);
    AutoRouter.of(context).replace(const DashboardRoute());
  }
}

class _MenuListTile extends StatelessWidget {
  final VoidCallback onTap;
  final Text title;

  const _MenuListTile({
    required this.onTap,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title.data!,
            style: TextStyle(
              fontSize: 14,
              color: states.contains(MaterialState.hovered) ? DesignColors.white_100 : title.style?.color ?? DesignColors.gray2_100,
            ),
          ),
        );
      },
    );
  }
}
