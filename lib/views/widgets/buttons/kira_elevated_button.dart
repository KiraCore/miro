import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraElevatedButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final String title;
  final double? width;
  final double height;

  const KiraElevatedButton({
    required this.onPressed,
    required this.title,
    this.width,
    this.height = 51,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraElevatedButton();
}

class _KiraElevatedButton extends State<KiraElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      disabled: widget.onPressed == null,
      onTap: widget.onPressed,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          decoration: BoxDecoration(
            gradient: _getButtonGradient(states),
            borderRadius: BorderRadius.circular(8),
          ),
          height: widget.height,
          width: widget.width,
          child: Center(
            child: Text(
              widget.title.toUpperCase(),
              style: const TextStyle(
                color: DesignColors.white_100,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Gradient _getButtonGradient(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.primaryButtonGradient;
    }
    return DesignColors.primaryButtonGradientHover;
  }
}
