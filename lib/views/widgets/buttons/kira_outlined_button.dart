import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraOutlinedButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String title;
  final double? height;
  final double? width;

  const KiraOutlinedButton({
    required this.onPressed,
    required this.title,
    this.width,
    this.height = 51,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                fontSize: 12,
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
    return DesignColors.gray2_100;
  }
}
