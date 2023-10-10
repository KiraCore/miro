import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraFilterChip extends StatelessWidget {
  final double size;
  final String title;
  final TextTheme textTheme;
  final VoidCallback? onTap;

  const KiraFilterChip({
    required this.size,
    required this.title,
    required this.textTheme,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      childBuilder: (Set<MaterialState> states) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: size, vertical: size / 2),
          decoration: BoxDecoration(
            color: _selectBackgroundColor(states),
            borderRadius: BorderRadius.all(
              Radius.circular(size * 2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.close, size: size),
              SizedBox(width: size / 2),
              Text(
                title,
                style: textTheme.bodySmall!.copyWith(
                  color: DesignColors.white2,
                  fontSize: size + size / 6,
                ),
              ),
            ],
          ),
        );
      },
      onTap: onTap,
    );
  }

  Color _selectBackgroundColor(Set<MaterialState> states) {
    Color color = DesignColors.grey2;
    if (states.contains(MaterialState.hovered)) {
      color = DesignColors.grey3;
    }
    return color;
  }
}
