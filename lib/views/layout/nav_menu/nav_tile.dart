import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/nav_menu/nav_menu_cubit.dart';
import 'package:miro/blocs/specific_blocs/nav_menu/nav_menu_state.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class NavTile extends StatefulWidget {
  final NavItemModel navItemModel;
  final GestureTapCallback? onTap;

  const NavTile({
    required this.navItemModel,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavTile();
}

class _NavTile extends State<NavTile> {
  final NavMenuCubit navMenuCubit = globalLocator<NavMenuCubit>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: widget.navItemModel.disabled ? 0.4 : 1,
      child: BlocBuilder<NavMenuCubit, NavMenuState>(
        bloc: navMenuCubit,
        builder: (BuildContext context, NavMenuState navMenuState) {
          bool selected = navMenuCubit.state.pathEquals(widget.navItemModel);

          return MouseStateListener(
            onTap: widget.onTap,
            disableSplash: true,
            mouseCursor: widget.navItemModel.disabled ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
            disabled: widget.navItemModel.disabled,
            childBuilder: (Set<MaterialState> materialStates) {
              Color foregroundColor = _selectForegroundColor(materialStates: materialStates, selected: selected);

              return Container(
                width: double.infinity,
                height: AppSizes.navMenuItemHeight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: _selectBackgroundColor(materialStates: materialStates, selected: selected),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      widget.navItemModel.icon,
                      size: 16,
                      color: foregroundColor,
                    ),
                    const SizedBox(width: 33),
                    Text(
                      widget.navItemModel.name,
                      style: textTheme.subtitle1!.copyWith(
                        color: foregroundColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _selectBackgroundColor({required Set<MaterialState> materialStates, required bool selected}) {
    if (widget.navItemModel.disabled) {
      return Colors.transparent;
    }
    bool hovered = materialStates.contains(MaterialState.hovered);
    if (hovered && selected) {
      return DesignColors.blue1_20;
    } else if (hovered || selected) {
      return DesignColors.blue1_10;
    } else {
      return Colors.transparent;
    }
  }

  Color _selectForegroundColor({required Set<MaterialState> materialStates, required bool selected}) {
    if (widget.navItemModel.disabled) {
      return DesignColors.gray2_100;
    }
    bool hovered = materialStates.contains(MaterialState.hovered);
    if (hovered || selected) {
      return DesignColors.blue1_100;
    } else {
      return DesignColors.gray2_100;
    }
  }
}
