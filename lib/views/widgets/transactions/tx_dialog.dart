import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TxDialog extends StatelessWidget {
  final Widget child;
  final String title;
  final double maxWidth;
  final String? subtitle;
  final Widget? suffixWidget;

  const TxDialog({
    required this.child,
    required this.title,
    this.maxWidth = 612,
    this.subtitle,
    this.suffixWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: DesignColors.blue1_10,
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        padding: _selectDialogPadding(context),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: textTheme.headline2!.copyWith(
                          color: DesignColors.white_100,
                        ),
                      ),
                    ),
                    if (suffixWidget != null) suffixWidget!,
                  ],
                ),
                if (subtitle != null) ...<Widget>[
                  const SizedBox(height: 12),
                  Text(
                    subtitle!,
                    style: textTheme.bodyText1!.copyWith(color: DesignColors.gray2_100),
                  ),
                ],
                const SizedBox(height: 30),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _selectDialogPadding(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 20);
    } else {
      return const EdgeInsets.all(40);
    }
  }
}
