import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';

class KiraDropzoneDropView extends StatelessWidget {
  const KiraDropzoneDropView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        S.of(context).keyfileDropFile.toUpperCase(),
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
      ),
    );
  }
}
