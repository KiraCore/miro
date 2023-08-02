import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:shimmer/shimmer.dart';

class PrefixedWidget extends StatelessWidget {
  final String prefix;
  final Widget? child;

  final bool loadingBool;
  final double height;
  final double width;
  final int? prefixMaxLines;
  final Widget? icon;

  const PrefixedWidget({
    required this.prefix,
    required this.child,
    this.loadingBool = false,
    this.height = 20,
    this.width = 80,
    this.prefixMaxLines,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        if (icon != null) ...<Widget>[
          icon!,
          const SizedBox(width: 12),
        ],
        Expanded(
          child: loadingBool
              ? Shimmer.fromColors(
                  baseColor: DesignColors.grey3,
                  highlightColor: DesignColors.grey2,
                  child: Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: DesignColors.grey2,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      prefix,
                      maxLines: prefixMaxLines,
                      overflow: prefixMaxLines != null ? TextOverflow.ellipsis : null,
                      style: (child != null ? textTheme.caption! : textTheme.bodyText2!).copyWith(
                        color: DesignColors.accent,
                      ),
                    ),
                    if (child != null) ...<Widget>[
                      const SizedBox(height: 4),
                      child!,
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}
