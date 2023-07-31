import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:shimmer/shimmer.dart';

class IRRecordTextValueWidget extends StatelessWidget {
  final bool loadingBool;
  final String label;
  final String? value;

  const IRRecordTextValueWidget({
    required this.loadingBool,
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    late Widget child;

    if (loadingBool) {
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
    } else {
      child = Text(value ?? '---', style: textTheme.bodyText1!.copyWith(color: DesignColors.white1));
    }

    return PrefixedWidget(prefix: label, child: child);
  }
}
