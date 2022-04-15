import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

enum StatusChipValue {
  pending,
  confirmed,
  failed,
  loading,
  notVerified,
}

class StatusChip extends StatelessWidget {
  final StatusChipValue value;

  const StatusChip({
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String textValue = _getText();
    Color color = _getColor();
    Color backgroundColor = color.withOpacity(0.2);

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            textValue,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  String _getText() {
    if (value == StatusChipValue.pending) {
      return 'Pending';
    } else if (value == StatusChipValue.failed) {
      return 'Failed';
    } else if (value == StatusChipValue.loading) {
      return 'Loading...';
    } else if (value == StatusChipValue.notVerified) {
      return 'Not Verified';
    }

    return 'Confirmed';
  }

  Color _getColor() {
    if (value == StatusChipValue.pending) {
      return DesignColors.yellow_100;
    } else if (value == StatusChipValue.failed) {
      return DesignColors.red_100;
    } else if (value == StatusChipValue.loading) {
      return DesignColors.gray2_100;
    } else if (value == StatusChipValue.notVerified) {
      return DesignColors.gray2_100;
    }
    return DesignColors.darkGreen_100;
  }
}
