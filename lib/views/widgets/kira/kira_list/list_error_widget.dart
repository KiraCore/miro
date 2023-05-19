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
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: DesignColors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Center(
        child: Text(
          errorMessage,
          style: const TextStyle(color: DesignColors.redStatus1),
        ),
      ),
    );
  }
}
