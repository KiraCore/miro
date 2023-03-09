import 'package:flutter/widgets.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class TxBroadcastStatusIcon extends StatelessWidget {
  final double size;
  final bool status;

  const TxBroadcastStatusIcon({
    required this.size,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late BoxDecoration boxDecoration;

    if (status) {
      boxDecoration = const BoxDecoration(
        shape: BoxShape.circle,
        color: DesignColors.greenStatus1,
      );
    } else {
      boxDecoration = const BoxDecoration(
        color: DesignColors.redStatus1,
        shape: BoxShape.circle,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: boxDecoration,
      child: Center(
        child: Icon(
          status ? AppIcons.done : AppIcons.cancel,
          size: 35,
          color: DesignColors.white1,
        ),
      ),
    );
  }
}
