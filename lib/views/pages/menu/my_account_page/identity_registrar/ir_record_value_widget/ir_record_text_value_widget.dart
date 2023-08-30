import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/expandable_text.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:shimmer/shimmer.dart';

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
      child = Shimmer.fromColors(
        baseColor: DesignColors.grey3,
        highlightColor: DesignColors.grey2,
        child: Container(
          width: 80,
          height: 20,
          decoration: const BoxDecoration(
            color: DesignColors.grey2,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      );
    } else if (widget.expandableBool == false) {
      child = Text(
        widget.value ?? '---',
        maxLines: widget.maxLines,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyText2!.copyWith(color: DesignColors.white1),
      );
    } else {
      child = ExpandableText(
        initialTextLength: const ResponsiveValue<int>(
          largeScreen: 500,
          mediumScreen: 300,
          smallScreen: 150,
        ).get(context),
        textLengthSeeMore: 500,
        text: Text(widget.value ?? '---', style: textTheme.bodyText2!.copyWith(color: DesignColors.white1)),
      );
    }

    return PrefixedWidget(prefix: widget.label, prefixMaxLines: 3, child: child);
  }
}
