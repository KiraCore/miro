import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/expandable_text.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRRecordTextValueWidget extends StatefulWidget {
  final bool loadingBool;
  final String label;
  final String? value;
  final bool expandableBool;
  final int? maxLines;

  const IRRecordTextValueWidget({
    required this.loadingBool,
    required this.label,
    required this.value,
    this.expandableBool = true,
    this.maxLines,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRRecordTextValueWidget();
}

class _IRRecordTextValueWidget extends State<IRRecordTextValueWidget> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    late Widget child;

    if (widget.loadingBool) {
      child = const LoadingContainer(
        height: 20,
        width: 80,
        circularBorderRadius: 5,
      );
    } else if (widget.expandableBool == false) {
      child = Text(
        widget.value ?? '---',
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
      );
    } else {
      child = ExpandableText(
        initialTextLength: const ResponsiveValue<int>(
          largeScreen: 500,
          mediumScreen: 300,
          smallScreen: 150,
        ).get(context),
        textLengthSeeMore: 500,
        text: Text(widget.value ?? '---', style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1)),
      );
    }

    return PrefixedWidget(prefix: widget.label, prefixMaxLines: 3, child: child);
  }
}
