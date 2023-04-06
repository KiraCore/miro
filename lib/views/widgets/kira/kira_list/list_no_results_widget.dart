import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';

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
        color: DesignColors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      width: double.infinity,
      child: Center(
        child: Text(S.of(context).errorNoResults),
      ),
    );
  }
}
