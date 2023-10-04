import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double height;
  final Icon? icon;

  const KiraTextButton({
    required this.label,
    required this.onPressed,
    this.height = 51,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: height,
      child: MouseStateListener(
        onTap: onPressed,
        childBuilder: (Set<MaterialState> states) {
          Color foregroundColor = states.contains(MaterialState.hovered) ? DesignColors.white1 : DesignColors.grey1;
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon!.icon, color: foregroundColor, size: icon!.size),
                const SizedBox(width: 10),
              ],
              Text(
                label,
                style: textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold, color: foregroundColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
