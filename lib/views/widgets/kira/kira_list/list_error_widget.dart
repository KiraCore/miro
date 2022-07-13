import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class ListErrorWidget extends StatelessWidget {
  final String errorMessage;
  final double? minHeight;

  const ListErrorWidget({
    required this.errorMessage,
    this.minHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: minHeight ?? double.infinity,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: DesignColors.red_100),
        ),
      ),
    );
  }
}
