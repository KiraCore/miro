import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/drawer/kira_drawer.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class DrawerWrapper extends StatefulWidget {
  const DrawerWrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerWrapper();
}

class _DrawerWrapper extends State<DrawerWrapper> {
  @override
  Widget build(BuildContext context) {
    return KiraDrawer(
      width: ResponsiveWidget.isSmallScreen(context) ? MediaQuery.of(context).size.width : 400,
      drawerColor: const Color(0xff121420),
      onClose: _onDrawerClose,
      onWillPop: _onWillPop,
      popButton: BlocBuilder<DrawerCubit, DrawerState>(builder: _buildPopButton),
      child: BlocBuilder<DrawerCubit, DrawerState>(
        builder: (BuildContext context, DrawerState state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _buildDrawerContent(state),
          );
        },
      ),
    );
  }

  Widget _buildDrawerContent(DrawerState state) {
    if (state is DrawerNavigate) {
      return state.currentRoute;
    }
    return const CenterLoadSpinner();
  }

  Widget _buildPopButton(BuildContext context, DrawerState state) {
    if (state is DrawerNavigate && state.canPop) {
      return IconButton(
        onPressed: _onDrawerPop,
        icon: const Icon(
          Icons.arrow_back,
          size: 22,
          color: DesignColors.gray2_100,
        ),
      );
    }
    return IconButton(
      onPressed: _onDrawerClose,
      icon: const Icon(
        Icons.close,
        size: 22,
        color: DesignColors.gray2_100,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    bool canPop = BlocProvider.of<DrawerCubit>(context).canPop;
    if (canPop) {
      _onDrawerPop();
    } else {
      _onDrawerClose();
    }
    return Future<bool>.value(canPop);
  }

  void _onDrawerPop() {
    KiraScaffold.of(context).popEndDrawer();
  }

  void _onDrawerClose() {
    KiraScaffold.of(context).closeEndDrawer();
  }
}
