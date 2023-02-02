import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class ListLoadingWidget extends StatelessWidget {
  final double? minHeight;

  const ListLoadingWidget({
    this.minHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      constraints: const BoxConstraints(minHeight: 500),
      decoration: BoxDecoration(
        color: DesignColors.blue1_10,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: const CenterLoadSpinner(),
    );
  }
}
