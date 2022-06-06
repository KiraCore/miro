import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraChipButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool selected;
  final EdgeInsets? margin;

  const KiraChipButton({
    required this.label,
    required this.onTap,
    required this.selected,
    required this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
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
              style: const TextStyle(
                color: DesignColors.white_100,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
