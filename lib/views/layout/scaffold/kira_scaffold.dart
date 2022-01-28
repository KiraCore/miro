import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar.dart';
import 'package:miro/views/layout/app_bar/mobile/backdrop/backdrop_app_bar.dart';
import 'package:miro/views/layout/app_bar/mobile/kira_app_bar_mobile.dart';
import 'package:miro/views/layout/nav_menu/nav_menu.dart';
import 'package:miro/views/widgets/generic/responsive_widget.dart';

class KiraScaffold extends StatefulWidget {
  final Widget body;
  final KiraAppBar appBar;
  final NavMenu navMenu;

  const KiraScaffold({
    required this.body,
    required this.appBar,
    required this.navMenu,
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
}
