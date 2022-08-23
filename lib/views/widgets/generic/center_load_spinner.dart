import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class CenterLoadSpinner extends StatelessWidget {
  final double? size;

  const CenterLoadSpinner({Key? key, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(
          color: DesignColors.blue1_100,
        ),
      ),
    );
  }
}
