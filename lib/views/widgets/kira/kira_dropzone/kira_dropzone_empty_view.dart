import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class KiraDropzoneEmptyView extends StatelessWidget {
  final String emptyLabel;
  final VoidCallback? onTap;

  const KiraDropzoneEmptyView({
    required this.emptyLabel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          emptyLabel,
          style: textTheme.bodyMedium!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(
              S.of(context).or,
              style: textTheme.bodyMedium!.copyWith(
                color: DesignColors.white1,
              ),
            ),
            TextLink(
              text: S.of(context).browse,
              textStyle: textTheme.bodyMedium!,
              onTap: onTap,
            ),
          ],
        ),
      ],
    );
  }
}
