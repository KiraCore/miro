import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class ListLoadingWidget extends StatelessWidget {
  final double? minHeight;

  const ListLoadingWidget({
    this.minHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: minHeight ?? double.infinity,
      child: const CenterLoadSpinner(),
    );
  }
}
