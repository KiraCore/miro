import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraOutlinedButton extends StatelessWidget {
  final String title;
  final GestureTapCallback? onPressed;
  final double? height;
  final double? width;
  final bool disabled;
  final bool uppercaseBool;
  final Color? borderColor;
  final Color? textColor;
  final Widget? leading;
  final Widget? trailing;

  const KiraOutlinedButton({
    required this.title,
    required this.onPressed,
    this.width,
    this.height = 51,
    this.disabled = false,
    this.uppercaseBool = true,
    this.borderColor,
    this.textColor,
    this.leading,
    this.trailing,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Opacity(
      opacity: disabled ? 0.3 : 1,
      child: MouseStateListener(
        disabled: disabled,
        onTap: disabled ? null : onPressed,
        childBuilder: (Set<MaterialState> states) {
          return Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(states),
              border: Border.all(
                color: _getBorderColor(states),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            width: width ?? double.infinity,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (leading != null) ...<Widget>[leading!, const SizedBox(width: 4)],
                Text(
                  uppercaseBool ? title.toUpperCase() : title,
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge!.copyWith(
                    color: _getTextColor(states),
                  ),
                ),
                if (trailing != null) ...<Widget>[const SizedBox(width: 4), trailing!],
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getBorderColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) && disabled == false) {
      return DesignColors.white1;
    }
    return borderColor ?? textColor?.withOpacity(0.5) ?? DesignColors.greyOutline;
  }

  Color _getTextColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.white1;
    }
    return textColor ?? DesignColors.white1;
  }

  Color _getBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered) && disabled == false) {
      return DesignColors.greyHover1;
    }
    return Colors.transparent;
  }
}
