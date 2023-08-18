import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class TxDialog extends StatelessWidget {
  final Widget child;
  final String title;
  final double maxWidth;
  final List<String>? subtitle;
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: const ResponsiveValue<double?>(
              largeScreen: null,
              mediumScreen: null,
              smallScreen: double.infinity,
            ).get(context),
            decoration: BoxDecoration(
              color: DesignColors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SingleChildScrollView(
              child: Padding(
                padding: _selectDialogPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            title,
                            style: textTheme.headline2!.copyWith(
                              color: DesignColors.white1,
                            ),
                          ),
                        ),
                        if (suffixWidget != null) suffixWidget!,
                      ],
                    ),
                    if (subtitle != null) ...<Widget>[
                      const SizedBox(height: 12),
                      ...subtitle!
                          .map(
                            (String message) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                message,
                                style: textTheme.bodyText1!.copyWith(color: DesignColors.orange),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                    const SizedBox(height: 30),
                    child,
                    if (ResponsiveWidget.isSmallScreen(context)) const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets _selectDialogPadding(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
    } else {
      return const EdgeInsets.all(40);
    }
  }
}
