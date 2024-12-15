import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/animated/animated_loading_border.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraElevatedButton extends StatefulWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final Widget? icon;
  final double? width;
  final double height;
  final bool disabled;
  final bool loadingBool;
  final Color? foregroundColor;

  const KiraElevatedButton({
    required this.onPressed,
    this.title,
    this.width,
    this.icon,
    this.foregroundColor,
    this.disabled = false,
    this.loadingBool = false,
    this.height = 51,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KiraElevatedButton();
}

class _KiraElevatedButton extends State<KiraElevatedButton> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      disabled: widget.disabled || widget.loadingBool,
      onTap: widget.disabled ? null : widget.onPressed,
      childBuilder: (Set<MaterialState> states) {
        Widget button = Opacity(
          opacity: widget.disabled || widget.loadingBool ? 0.3 : 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.foregroundColor != null ? null : _getButtonGradient(states),
              color: widget.foregroundColor?.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            height: widget.height,
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.icon != null) ...<Widget>[
                  widget.icon!,
                  if (widget.title != null) const SizedBox(width: 12),
                ],
                if (widget.title != null) ...<Widget>[
                  Text(
                    widget.title!.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: textTheme.labelLarge!.copyWith(
                      color: widget.foregroundColor ?? DesignColors.background,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
        if (widget.loadingBool) {
          return AnimatedLoadingBorder(
            // NOTE: borderRadius of child Container + padding of AnimatedLoadingBorder
            cornerRadius: 10.0,
            borderColor: DesignColors.greenStatus1,
            borderWidth: 4.0,
            padding: const EdgeInsets.all(2), // padding
            duration: const Duration(seconds: 2),
            child: button,
          );
        }
        return button;
      },
    );
  }

  Gradient _getButtonGradient(Set<MaterialState> states) {
    if (((widget.disabled || widget.loadingBool) == false) && states.contains(MaterialState.hovered)) {
      return DesignColors.primaryButtonGradientHover;
    }
    return DesignColors.primaryButtonGradient;
  }
}
