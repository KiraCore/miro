import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar_mobile.dart';
import 'package:miro/views/layout/app_bar/mobile_backdrop/backdrop_app_bar.dart';
import 'package:miro/views/layout/nav_menu/nav_menu.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class KiraScaffold extends StatefulWidget {
  final Widget body;
  final KiraAppBar appBar;
  final NavMenu navMenu;
  final Widget? endDrawer;
  final Color? drawerScrimColor;

  const KiraScaffold({
    required this.body,
    required this.appBar,
    required this.navMenu,
    this.drawerScrimColor,
    this.endDrawer,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KiraScaffoldState();

  /// Provides access to the state from everywhere in the widget tree.
  static KiraScaffoldState of(BuildContext context) {
    final KiraScaffoldState? result = context.findAncestorStateOfType<KiraScaffoldState>();
    if (result != null) {
      return result;
    }
    throw Exception('Cannot get KiraScaffold state');
  }
}

class KiraScaffoldState extends State<KiraScaffold> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: 0,
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: widget.endDrawer,
      body: ResponsiveWidget(
        largeScreen: _DesktopScaffold(
          appBar: widget.appBar,
          body: _buildAppBody(),
          navMenu: widget.navMenu,
        ),
        mediumScreen: _MobileScaffold(
          body: _buildAppBody(),
          appBar: widget.appBar,
          navMenu: widget.navMenu,
        ),
      ),
    );
  }

  Widget _buildAppBody() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: widget.body,
    );
  }

  void navigateEndDrawerRoute(Widget page) {
    BlocProvider.of<DrawerCubit>(context).navigate(scaffoldKey, page);
  }

  void replaceEndDrawerRoute(Widget page) {
    BlocProvider.of<DrawerCubit>(context).replace(scaffoldKey, page);
  }

  void popEndDrawer() {
    BlocProvider.of<DrawerCubit>(context).pop(scaffoldKey);
  }

  void closeEndDrawer() {
    BlocProvider.of<DrawerCubit>(context).closeDrawer(scaffoldKey);
  }
}

class _DesktopScaffold extends StatelessWidget {
  final Widget body;
  final Widget navMenu;
  final Widget appBar;

  const _DesktopScaffold({
    required this.body,
    required this.navMenu,
    required this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: DesignColors.blue1_10,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: navMenu,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              appBar,
              Expanded(child: body),
            ],
          ),
        ),
      ],
    );
  }
}

class _MobileScaffold extends StatelessWidget {
  final KiraAppBar appBar;
  final Widget body;
  final Widget navMenu;

  const _MobileScaffold({
    required this.appBar,
    required this.body,
    required this.navMenu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BackdropAppBar(
          appbarBuilder: (bool isCollapsed) {
            return KiraAppBarMobile(
              mobileDecoration: appBar.mobileDecoration,
              isCollapsed: isCollapsed,
              menu: Column(
                children: <Widget>[
                  const SizedBox(height: 25),
                  appBar.sidebar,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: navMenu,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Expanded(child: body),
      ],
    );
  }
}
