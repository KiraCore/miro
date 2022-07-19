import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';

class BackdropContent extends StatelessWidget {
  final Duration backdropDuration;
  final bool collapsed;
  final Widget menu;

  const BackdropContent({
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
