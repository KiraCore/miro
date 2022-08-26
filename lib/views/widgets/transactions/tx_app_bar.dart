import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TxAppBar extends StatelessWidget {
  const TxAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _selectAppBarPadding(context),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => _closeDialog(context),
            color: DesignColors.gray2_100,
            icon: const Icon(
              AppIcons.cancel,
              size: 24,
              color: DesignColors.gray2_100,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _closeDialog(BuildContext context) {
    if (AutoRouter.of(context).canPopSelfOrChildren) {
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).replaceNamed('/');
    }
  }

  EdgeInsets _selectAppBarPadding(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 10, vertical: 30);
    } else {
      return const EdgeInsets.all(40);
    }
  }
}
