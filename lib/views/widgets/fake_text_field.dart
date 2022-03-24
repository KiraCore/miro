import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class FakeTextField extends StatelessWidget {
  final String? value;
  final String label;
  final Icon? icon;

  const FakeTextField({
    required this.label,
    this.value,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late TextStyle labelStyle;
    if (value != null) {
      labelStyle = const TextStyle(fontSize: 12, color: DesignColors.gray2_100);
    } else {
      labelStyle = const TextStyle(fontSize: 13, color: DesignColors.gray2_100);
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: labelStyle,
              ),
              if (value != null)
                Text(
                  value!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: DesignColors.white_100,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
