import 'package:flutter/material.dart';
import 'package:miro/views/layout/app_bar/kira_app_bar_mobile_header.dart';
import 'package:miro/views/layout/app_bar/mobile_backdrop/backdrop_content.dart';
import 'package:miro/views/layout/app_bar/model/app_bar_mobile_decoration.dart';

class KiraAppBarMobile extends StatefulWidget {
  final AppBarMobileDecoration mobileDecoration;
  final Widget menu;
  final bool isCollapsed;

  const KiraAppBarMobile({
    required this.mobileDecoration,
    required this.menu,
    required this.isCollapsed,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraAppBarMobile();
}

class _KiraAppBarMobile extends State<KiraAppBarMobile> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.mobileDecoration.backgroundColor),
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.mobileDecoration.backdropColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              KiraAppBarMobileHeader(
                leading: widget.mobileDecoration.leading,
                title: widget.mobileDecoration.title,
                trailing: widget.mobileDecoration.trailing,
              ),
              BackdropContent(
                backdropDuration: widget.mobileDecoration.backdropDuration,
                collapsed: widget.isCollapsed,
                menu: widget.menu,
              )
            ],
          ),
        ),
      ),
    );
  }
}
