import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';

class KiraChipButton extends StatelessWidget {
  final String label;
  final EdgeInsets? margin;
  final VoidCallback onTap;
  final bool selected;

  const KiraChipButton({
    required this.label,
    required this.margin,
    required this.onTap,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return MouseStateListener(
      mouseCursor: SystemMouseCursors.click,
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          margin: margin,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: selected ? DesignColors.blue1_100 : Colors.transparent,
            border: Border.all(
              color: selected ? DesignColors.blue1_100 : DesignColors.gray2_100,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              label,
              style: textTheme.caption!.copyWith(
                color: DesignColors.white_100,
              ),
            ),
          ),
        );
      },
    );
  }
}
