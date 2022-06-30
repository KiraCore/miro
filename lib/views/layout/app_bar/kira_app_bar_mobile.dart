import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
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
              _AppBarHeader(
                leading: widget.mobileDecoration.leading,
                title: widget.mobileDecoration.title,
                trailing: widget.mobileDecoration.trailing,
              ),
              _BackdropContent(
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

class _AppBarHeader extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;

  const _AppBarHeader({
    this.leading,
    this.title,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.kKiraAppBarHeight - 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          leading ?? const SizedBox(),
          if (title != null) title!,
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}

class _BackdropContent extends StatelessWidget {
  final Duration backdropDuration;
  final bool collapsed;
  final Widget menu;

  const _BackdropContent({
    required this.backdropDuration,
    required this.collapsed,
    required this.menu,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: backdropDuration,
      child: SizedBox(
        width: double.infinity,
        height: collapsed ? MediaQuery.of(context).size.height - AppSizes.kKiraAppBarHeight : 0,
        child: menu,
      ),
    );
  }
}
