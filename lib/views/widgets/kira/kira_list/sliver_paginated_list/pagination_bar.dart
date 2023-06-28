import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class PaginationBar extends StatelessWidget {
  final bool lastPageBool;
  final int pageIndex;
  final VoidCallback onNextPageSelected;
  final VoidCallback onPreviousPageSelected;

  const PaginationBar({
    required this.lastPageBool,
    required this.pageIndex,
    required this.onNextPageSelected,
    required this.onPreviousPageSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool firstPageBool = pageIndex == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: firstPageBool ? null : onPreviousPageSelected,
          icon: const Icon(AppIcons.chevron_left),
        ),
        const SizedBox(width: 50),
        Text((pageIndex + 1).toString(), style: const TextStyle(color: DesignColors.white1, fontSize: 16)),
        const SizedBox(width: 50),
        IconButton(
          onPressed: lastPageBool ? null : onNextPageSelected,
          icon: const Icon(AppIcons.chevron_right),
        ),
      ],
    );
  }
}
