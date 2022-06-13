import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

enum StatusChipType {
  loading,
  failed,
  success,
  warning,
}

class StatusChip extends StatelessWidget {
  final StatusChipType? type;
  final String label;
  final Icon? icon;

  const StatusChip({
    required this.type,
    required this.label,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = chipColor;
    Color backgroundColor = color.withOpacity(0.2);

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(
                  icon!.icon,
                  color: icon!.color ?? color,
                  size: 14,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color get chipColor {
    switch (type) {
      case StatusChipType.loading:
        return DesignColors.gray2_100;
      case StatusChipType.failed:
        return DesignColors.red_100;
      case StatusChipType.warning:
        return DesignColors.yellow_100;
      case StatusChipType.success:
        return DesignColors.blue1_100;
      default:
        return DesignColors.gray2_100;
    }
  }
}
