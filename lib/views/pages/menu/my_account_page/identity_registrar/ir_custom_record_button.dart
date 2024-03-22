import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/buttons/kira_text_button.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRCustomRecordButton extends StatelessWidget {
  final VoidCallback onTap;

  const IRCustomRecordButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: EdgeInsets.only(left: const ResponsiveValue<double>(largeScreen: 20, smallScreen: 0).get(context)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: KiraTextButton(
          label: S.of(context).irAddCustomRecord,
          onPressed: onTap,
          icon: const Icon(AppIcons.add),
        ),
      ),
    );
  }
}
