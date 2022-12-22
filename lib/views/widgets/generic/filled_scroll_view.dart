import 'package:flutter/cupertino.dart';

class FilledScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;

  FilledScrollView({
    required this.child,
    ScrollController? scrollController,
    Key? key,
  }) : scrollController = scrollController ?? ScrollController(), super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }
}
