import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/loading_container.dart';

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
          child: LoadingContainer(
            height: textTheme.headlineMedium?.fontSize,
            width: 100,
            boxConstraints: const BoxConstraints(minWidth: 100),
          ),
        ),
      );
    } else {
      return child;
    }
  }
}
