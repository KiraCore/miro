import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  final String text;
  final Color color;
  final Widget? icon;

  const StatusChip({
    required this.text,
    required this.color,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            icon!,
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: textTheme.bodySmall!.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
