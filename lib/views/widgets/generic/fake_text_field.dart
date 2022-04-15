import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class FakeTextField extends StatelessWidget {
  final Widget? child;
  final String label;
  final Icon? icon;
  final TextStyle? emptyLabelStyle;
  final double spacing;

  const FakeTextField({
    required this.label,
    this.spacing = 2,
    this.child,
    this.emptyLabelStyle,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late TextStyle _labelStyle;
    if (child != null) {
      _labelStyle = const TextStyle(fontSize: 12, color: DesignColors.gray2_100);
    } else {
      _labelStyle = (emptyLabelStyle ?? const TextStyle()).copyWith(
        fontSize: emptyLabelStyle?.fontSize ?? 13,
        color: emptyLabelStyle?.color ?? DesignColors.gray2_100,
      );
    }
    return Container(
      padding: const EdgeInsets.only(right: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: icon!,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: _labelStyle,
                ),
                if (child != null) SizedBox(height: spacing),
                if (child is Text)
                  Text(
                    (child as Text).data!,
                    style: ((child as Text).style ?? const TextStyle()).copyWith(
                      fontSize: (child as Text).style?.fontSize ?? 13,
                      color: (child as Text).style?.color ?? DesignColors.white_100,
                    ),
                  )
                else if (child is Widget)
                  child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
