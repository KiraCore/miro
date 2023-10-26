import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class DateRangeDropdownButton extends StatelessWidget {
  final VoidCallback onTap;
  final DateTime? startDateTime;
  final DateTime? endDateTime;

  const DateRangeDropdownButton({
    required this.onTap,
    this.startDateTime,
    this.endDateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle dateTextStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return MouseStateListener(
      onTap: onTap,
      childBuilder: (Set<MaterialState> states) {
        return Container(
          width: 240,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _selectBackgroundColor(states),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _selectBorderColor(states),
              width: 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(AppIcons.calendar, size: 20),
              const SizedBox(width: 18),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).txDateDropdownStartDate,
                  child: Text(
                    _buildDateString(startDateTime),
                    overflow: TextOverflow.ellipsis,
                    style: dateTextStyle,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrefixedWidget(
                  prefix: S.of(context).txDateDropdownEndDate,
                  child: Text(
                    _buildDateString(endDateTime),
                    overflow: TextOverflow.ellipsis,
                    style: dateTextStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _selectBackgroundColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.greyHover1;
    }
    return Colors.transparent;
  }

  Color _selectBorderColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return DesignColors.white1;
    }
    return DesignColors.greyOutline;
  }

  String _buildDateString(DateTime? dateTime) {
    return dateTime != null ? DateFormat('dd.MM.yyyy').format(dateTime) : '---';
  }
}
