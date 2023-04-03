import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class AccountMenuList extends StatelessWidget {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  final VoidCallback? onItemTap;

  AccountMenuList({
    this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _MenuListTile(
          onTap: () => _onNavigateToMyAccountPressed(context),
          title: 'My account',
        ),
        const _MenuListTile(
          onTap: null,
          title: 'Settings',
        ),
        _MenuListTile(
          onTap: () => _pressSignOutButton(context),
          title: 'Sign Out',
          color: DesignColors.redStatus1,
        ),
      ],
    );
  }

  void _onNavigateToMyAccountPressed(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    KiraRouter.of(context).navigate(const MyAccountRoute());
  }

  void _pressSignOutButton(BuildContext context) {
    if (onItemTap != null) {
      onItemTap!();
    }
    authCubit.signOut();
    KiraRouter.of(context).navigate(const DashboardRoute());
  }
}

class _MenuListTile extends StatelessWidget {
  final String title;
  final Color? color;
  final VoidCallback? onTap;

  const _MenuListTile({
    required this.title,
    this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        Color color = _selectColor(states);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(color: _selectBackgroundColor(states)),
          child: Text(
            title,
            style: textTheme.bodyText2!.copyWith(
              color: onTap != null ? color : color.withOpacity(0.5),
            ),
          ),
        );
      },
    );
  }

  Color _selectColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.white1;
    } else if (color != null) {
      return color!;
    } else {
      return DesignColors.white2;
    }
  }

  Color _selectBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.greyHover2;
    } else {
      return Colors.transparent;
    }
  }
}
