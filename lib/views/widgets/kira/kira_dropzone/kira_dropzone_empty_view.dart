import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/a_kira_dropzone_state.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/text_link.dart';

class KiraDropzoneEmptyView<E extends AKiraDropzoneState> extends StatelessWidget {
  final String emptyLabel;
  final AKiraDropzoneCubit<E> kiraDropzoneCubit;

  const KiraDropzoneEmptyView({
    required this.emptyLabel,
    required this.kiraDropzoneCubit,
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
              onTap: kiraDropzoneCubit.uploadFileManually,
            ),
          ],
        ),
      ],
    );
  }
}
