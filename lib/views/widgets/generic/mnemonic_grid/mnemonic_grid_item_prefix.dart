import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class MnemonicGridItemPrefix extends StatelessWidget {
  final int index;
  final bool? valid;

  const MnemonicGridItemPrefix({
    required this.index,
    this.valid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      index.toString(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: valid == true ? DesignColors.darkGreen_100 : DesignColors.gray2_100,
      ),
    );
  }
}
