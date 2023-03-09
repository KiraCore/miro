import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/drawer/drawer_app_bar.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class KiraDrawer extends StatefulWidget {
  final Widget child;
  final double width;

  const KiraDrawer({
    required this.child,
    this.width = 400,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraDrawer();
}

class _KiraDrawer extends State<KiraDrawer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleDrawerShadowTap(context),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: SizedBox(
          width: widget.width,
          height: MediaQuery.of(context).size.height,
          child: Drawer(
            backgroundColor: DesignColors.background,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: DesignColors.background,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DrawerAppBar(
                      onClose: _handleDrawerClose,
                      onPop: _handleDrawerPop,
                    ),
                    Padding(
                      padding:
                          ResponsiveWidget.isSmallScreen(context) ? const EdgeInsets.symmetric(horizontal: 20) : const EdgeInsets.symmetric(horizontal: 32),
                      child: widget.child,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDrawerShadowTap(BuildContext context) {
    FocusScopeNode isFocused = FocusScope.of(context);
    if (!isFocused.hasPrimaryFocus) {
      isFocused.unfocus();
    }
  }

  Future<bool> _onWillPop() async {
    bool canPop = BlocProvider.of<DrawerCubit>(context).canPop;
    if (canPop) {
      _handleDrawerPop();
    } else {
      _handleDrawerClose();
    }
    return Future<bool>.value(canPop);
  }

  void _handleDrawerPop() {
    KiraScaffold.of(context).popEndDrawer();
  }

  void _handleDrawerClose() {
    KiraScaffold.of(context).closeEndDrawer();
  }
}
