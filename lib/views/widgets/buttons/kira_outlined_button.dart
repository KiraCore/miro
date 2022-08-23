import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraOutlinedButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String title;
  final double? height;
  final double? width;
  final Color? borderColor;

  const KiraOutlinedButton({
    required this.onPressed,
    required this.title,
    this.borderColor,
    this.width,
    this.height = 51,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      onTap: onPressed,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _getBorderColor(states),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          width: width ?? double.infinity,
          height: height,
          child: Center(
            child: Text(
              title.toUpperCase(),
              style: textTheme.button!.copyWith(
                color: DesignColors.white_100,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getBorderColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.gray3_100;
    }
    return borderColor ?? DesignColors.gray2_100;
  }
}
