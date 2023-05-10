import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/layout/drawer/a_drawer_state.dart';
import 'package:miro/blocs/layout/drawer/drawer_cubit.dart';
import 'package:miro/blocs/layout/drawer/states/drawer_visible_state.dart';
import 'package:miro/views/layout/drawer/kira_drawer.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class DrawerWrapper extends StatelessWidget {
  const DrawerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KiraDrawer(
      width: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width : 400,
      child: BlocBuilder<DrawerCubit, ADrawerState>(
        builder: (BuildContext context, ADrawerState drawerState) {
          return AnimatedSwitcher(
            layoutBuilder: _buildDrawerPage,
            duration: const Duration(milliseconds: 250),
            child: _buildDrawerContent(drawerState),
          );
        },
      ),
    );
  }

  Widget _buildDrawerPage(Widget? currentChild, List<Widget> previousChildren) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }

  Widget _buildDrawerContent(ADrawerState drawerState) {
    if (drawerState is DrawerVisibleState) {
      return drawerState.currentRoute;
    }
    return const CenterLoadSpinner();
  }
}
