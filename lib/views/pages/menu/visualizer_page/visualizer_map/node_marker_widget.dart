import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class NodeMarkerWidget extends StatelessWidget {
  const NodeMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 1, color: DesignColors.white2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: DesignColors.white1,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
