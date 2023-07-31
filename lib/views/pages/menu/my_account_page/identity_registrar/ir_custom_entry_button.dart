import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';

class IRCustomEntryButton extends StatelessWidget {
  final VoidCallback onTap;

  const IRCustomEntryButton({
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
        child: MouseStateListener(
          onTap: onTap,
          childBuilder: (Set<MaterialState> states) {
            Color foregroundColor = states.contains(MaterialState.hovered) ? DesignColors.white1 : DesignColors.grey1;
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(AppIcons.add, color: foregroundColor),
                const SizedBox(width: 10),
                Text(
                  S.of(context).irAddCustomEntry,
                  style: TextStyle(fontWeight: FontWeight.bold, color: foregroundColor),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
