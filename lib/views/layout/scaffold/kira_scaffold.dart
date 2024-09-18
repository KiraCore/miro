import 'package:flutter/material.dart';
import 'package:miro/blocs/layout/drawer/drawer_cubit.dart';
import 'package:miro/blocs/pages/metamask/metamask_integration_provider.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/views/layout/nav_menu/model/nav_item_model.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold_desktop.dart';
import 'package:miro/views/layout/scaffold/kira_scaffold_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_background.dart';
import 'package:provider/provider.dart';

class KiraScaffold extends StatefulWidget {
  final Widget body;
  final List<NavItemModel> navItemModelList;
  final Color? drawerScrimColor;
  final Widget? endDrawer;

  const KiraScaffold({
    required this.body,
    required this.navItemModelList,
    this.drawerScrimColor,
    this.endDrawer,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraScaffold();

  /// Provides access to the state from everywhere in the widget tree.
  static _KiraScaffold of(BuildContext context) {
    final _KiraScaffold? kiraScaffold = context.findAncestorStateOfType<_KiraScaffold>();
    if (kiraScaffold != null) {
      return kiraScaffold;
    } else {
      throw Exception('Cannot get KiraScaffold state');
    }
  }
}

class _KiraScaffold extends State<KiraScaffold> {
  final DrawerCubit drawerCubit = globalLocator<DrawerCubit>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget kiraScaffoldDesktop = KiraScaffoldDesktop(
      navItemModelList: widget.navItemModelList,
      child: widget.body,
    );

    Widget kiraScaffoldMobile = KiraScaffoldMobile(
      navItemModelList: widget.navItemModelList,
      child: widget.body,
    );

    return ChangeNotifierProvider<MetaMaskProvider>(
      create: (BuildContext context) => MetaMaskProvider()..init(),
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          key: scaffoldKey,
          drawerScrimColor: widget.drawerScrimColor,
          drawerEdgeDragWidth: 0,
          drawerEnableOpenDragGesture: false,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: widget.endDrawer,
          body: GestureDetector(
            onTap: () => _handleActionLayoutFocus(context),
            child: KiraBackground(
              child: ResponsiveWidget(
                largeScreen: kiraScaffoldDesktop,
                mediumScreen: kiraScaffoldDesktop,
                smallScreen: kiraScaffoldMobile,
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateEndDrawerRoute(Widget page) {
    drawerCubit.navigate(scaffoldKey, page);
  }

  void replaceEndDrawerRoute(Widget page) {
    drawerCubit.replace(scaffoldKey, page);
  }

  void popEndDrawer() {
    drawerCubit.pop(scaffoldKey);
  }

  void closeEndDrawer() {
    drawerCubit.closeDrawer(scaffoldKey);
  }

  void _handleActionLayoutFocus(BuildContext context) {
    FocusScopeNode isFocused = FocusScope.of(context);
    if (!isFocused.hasPrimaryFocus) {
      isFocused.unfocus();
    }
  }
}
