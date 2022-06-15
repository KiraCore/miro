import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

const double _kButtonHeight = 30;
const EdgeInsets _kButtonPadding = EdgeInsets.symmetric(horizontal: 12);

class SortDropdownButton extends StatelessWidget {
  final String title;

  const SortDropdownButton({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kButtonHeight,
      padding: _kButtonPadding,
      decoration: BoxDecoration(
        border: Border.all(
          color: DesignColors.gray2_100,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontSize: 13,
                color: DesignColors.gray2_100,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            color: DesignColors.gray2_100,
            size: 15,
          ),
        ],
      ),
    );
  }
}
