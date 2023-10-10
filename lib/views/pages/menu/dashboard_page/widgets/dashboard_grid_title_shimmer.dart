import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:shimmer/shimmer.dart';

class DashboardGridTileShimmer extends StatelessWidget {
  final bool enabled;
  final Widget child;

  const DashboardGridTileShimmer({
    required this.child,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (enabled) {
      return Opacity(
        opacity: 0.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Shimmer.fromColors(
            enabled: enabled,
            baseColor: DesignColors.grey3,
            highlightColor: DesignColors.grey2,
            child: Container(
              width: 100,
              color: DesignColors.grey2,
              constraints: const BoxConstraints(minWidth: 100),
              child: Text('', style: textTheme.headlineMedium),
            ),
          ),
        ),
      );
    } else {
      return child;
    }
  }
}
