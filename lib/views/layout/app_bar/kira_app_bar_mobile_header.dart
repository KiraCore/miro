import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';

class KiraAppBarMobileHeader extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;

  const KiraAppBarMobileHeader({
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
