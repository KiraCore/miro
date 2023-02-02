import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';

class ListNoResultsWidget extends StatelessWidget {
  const ListNoResultsWidget({
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
      child: const Center(
        child: Text('No results'),
      ),
    );
  }
}
