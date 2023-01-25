import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraOutlinedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? onPressed;
  final double? height;
  final double? width;
  final bool disabled;
  final Color? borderColor;

  const KiraOutlinedButton({
    required this.title,
    required this.onPressed,
    this.width,
    this.height = 51,
    this.disabled = false,
    this.borderColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: disabled ? 0.3 : 1,
      child: MouseStateListener(
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
                textAlign: TextAlign.center,
                style: textTheme.button!.copyWith(
                  color: DesignColors.white_100,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getBorderColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.gray3_100;
    }
    return borderColor ?? DesignColors.gray2_100;
  }
}
