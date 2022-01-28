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
      decoration: BoxDecoration(
        color: widget.mobileDecoration.backgroundColor,
      ),
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
              _buildAppBarContent(),
              _buildBackdrop(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarContent() {
    return SizedBox(
      height: AppSizes.kKiraAppBarHeight - 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          widget.mobileDecoration.leading ?? const SizedBox(),
          widget.mobileDecoration.trailing ?? const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildBackdrop() {
    return AnimatedSize(
      duration: widget.mobileDecoration.backdropDuration,
      child: SizedBox(
        width: double.infinity,
        height: widget.isCollapsed ? MediaQuery.of(context).size.height - AppSizes.kKiraAppBarHeight : 0,
        child: widget.menu,
      ),
    );
  }
}
