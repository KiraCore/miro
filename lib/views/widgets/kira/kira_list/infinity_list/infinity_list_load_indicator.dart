import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class InfinityListLoadIndicator extends StatelessWidget {
  const InfinityListLoadIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: const CenterLoadSpinner(),
    );
  }
}
