import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/a_drawer_state.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/blocs/specific_blocs/drawer/states/drawer_visible_state.dart';
import 'package:miro/config/theme/design_colors.dart';

class DrawerPopButton extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onPop;
  final double size;
  final Color color;

  const DrawerPopButton({
    required this.onClose,
    required this.onPop,
    this.size = 24,
    this.color = DesignColors.gray2_100,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerCubit, ADrawerState>(
      builder: (BuildContext context, ADrawerState drawerState) {
        bool canPop = drawerState is DrawerVisibleState && drawerState.canPop;
        if (canPop) {
          return IconButton(
            onPressed: onPop,
            icon: Icon(
              Icons.arrow_back,
              size: size,
              color: color,
            ),
          );
        }
        return IconButton(
          onPressed: onClose,
          icon: Icon(
            Icons.close,
            size: size,
            color: color,
          ),
        );
      },
    );
  }
}
