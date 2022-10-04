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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF23E73C), Color(0xFF95E09F)],
        ),
      );
    } else {
      boxDecoration = const BoxDecoration(
        color: DesignColors.red_100,
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
          color: DesignColors.white_100,
        ),
      ),
    );
  }
}
