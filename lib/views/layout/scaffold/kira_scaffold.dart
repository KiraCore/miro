import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/drawer/drawer_cubit.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar.dart';
import 'package:miro/views/layout/app_bar/mobile/backdrop/backdrop_app_bar.dart';
import 'package:miro/views/layout/app_bar/mobile/kira_app_bar_mobile.dart';
import 'package:miro/views/layout/nav_menu/nav_menu.dart';
import 'package:miro/views/widgets/generic/responsive_widget.dart';

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
        largeScreen: _buildDesktop(),
        mediumScreen: _buildMobile(),
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: <Widget>[
        widget.navMenu,
        Expanded(
          child: Column(
            children: <Widget>[
              widget.appBar,
              Expanded(
                child: _buildAppBody(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      children: <Widget>[
        BackdropAppBar(
          appbarBuilder: (bool isCollapsed) {
            return KiraAppBarMobile(
              mobileDecoration: widget.appBar.mobileDecoration,
              isCollapsed: isCollapsed,
              menu: widget.navMenu,
            );
          },
        ),
        Expanded(
          child: widget.body,
        ),
      ],
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
