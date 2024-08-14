import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_range_dropdown.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_text_field.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/kira/kira_chip_button.dart';

class DateRangeDropdownPopMenu extends StatefulWidget {
  final DatePickerResult onDateTimeChanged;
  final PopWrapperController popWrapperController;
  final DateTime? initialStartDateTime;
  final DateTime? initialEndDateTime;

  const DateRangeDropdownPopMenu({
    required this.onDateTimeChanged,
    required this.popWrapperController,
    this.initialStartDateTime,
    this.initialEndDateTime,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateRangeDropdownPopMenu();
}

class _DateRangeDropdownPopMenu extends State<DateRangeDropdownPopMenu> {
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');

  final TextEditingController startDateTimeController = TextEditingController();
  final TextEditingController endDateTimeController = TextEditingController();

  late DateTime? startDateTime = widget.initialStartDateTime;
  late DateTime? endDateTime = widget.initialEndDateTime;

  @override
  void initState() {
    super.initState();
    _handleDateChanged(startDateTime, endDateTime);
  }

  @override
  void dispose() {
    startDateTimeController.dispose();
    endDateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    String startDateString = startDateTime != null ? dateFormat.format(startDateTime!) : '---';
    String endDateString = endDateTime != null ? dateFormat.format(endDateTime!) : '---';
    String currentDateString = dateFormat.format(DateTime.now());
    String yesterdayDateString = dateFormat.format(DateTime.now().subtract(const Duration(days: 1)));

    bool todaySelectedBool = startDateString == currentDateString && endDateString == currentDateString;
    bool yesterdaySelectedBool = startDateString == yesterdayDateString && endDateString == yesterdayDateString;
    bool weekSelectedBool = startDateString == dateFormat.format(DateTime.now().subtract(const Duration(days: 7))) && endDateString == currentDateString;
    bool monthSelectedBool = startDateString == dateFormat.format(DateTime.now().subtract(const Duration(days: 30))) && endDateString == currentDateString;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: 310,
      height: 440,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 34,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: DateTextField(
                    label: S.of(context).txDateDropdownStartDate,
                    textEditingController: startDateTimeController,
                    onDateChanged: (DateTime? dateTime) => _handleDateChanged(dateTime, endDateTime),
                  ),
                ),
                const Text(' - '),
                Expanded(
                  child: DateTextField(
                    label: S.of(context).txDateDropdownEndDate,
                    textEditingController: endDateTimeController,
                    onDateChanged: (DateTime? dateTime) => _handleDateChanged(startDateTime, dateTime),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: <Widget>[
                KiraChipButton(
                  label: S.of(context).txDateDropdownAll,
                  onTap: () => _handleDateChanged(null, null),
                  selected: startDateTime == null || endDateTime == null,
                ),
                KiraChipButton(
                  label: S.of(context).txDateDropdownOneMonth,
                  onTap: () => _handleDateChanged(DateTime.now().subtract(const Duration(days: 30)), DateTime.now()),
                  selected: monthSelectedBool,
                ),
                KiraChipButton(
                  label: S.of(context).txDateDropdownOneWeek,
                  onTap: () => _handleDateChanged(DateTime.now().subtract(const Duration(days: 7)), DateTime.now()),
                  selected: weekSelectedBool,
                ),
                KiraChipButton(
                  label: S.of(context).txDateDropdownYesterday,
                  onTap: () => _handleDateChanged(DateTime.now().subtract(const Duration(days: 1)), DateTime.now().subtract(const Duration(days: 1))),
                  selected: yesterdaySelectedBool,
                ),
                KiraChipButton(
                  label: S.of(context).txDateDropdownToday,
                  onTap: () => _handleDateChanged(DateTime.now(), DateTime.now()),
                  selected: todaySelectedBool,
                ),
              ],
            ),
          ),
          Expanded(
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                firstDayOfWeek: 1,
                lastDate: DateTime.now(),
                calendarType: CalendarDatePicker2Type.range,
                controlsTextStyle: textTheme.bodySmall!.copyWith(color: DesignColors.white2),
                selectedDayHighlightColor: DesignColors.greenStatus1,
              ),
              value: <DateTime?>[startDateTime, endDateTime],
              onValueChanged: _applyDateRange,
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: KiraOutlinedButton(
                    height: 40,
                    title: S.of(context).txDateDropdownCancel,
                    onPressed: () => widget.popWrapperController.hideTooltip(),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: KiraElevatedButton(
                    height: 40,
                    title: S.of(context).txDateDropdownSave,
                    onPressed: () {
                      widget.onDateTimeChanged(startDateTime, endDateTime);
                      widget.popWrapperController.hideTooltip();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _applyDateRange(List<DateTime?>? selectedDates) {
    _handleDateChanged(selectedDates?.elementAtOrNull(0), selectedDates?.elementAtOrNull(1));
  }

  void _handleDateChanged(DateTime? startDateTime, DateTime? endDateTime) {
    this.startDateTime = startDateTime != null ? DateTime(startDateTime.year, startDateTime.month, startDateTime.day, 0, 0) : null;
    this.endDateTime = endDateTime != null ? DateTime(endDateTime.year, endDateTime.month, endDateTime.day, 23, 59) : null;

    startDateTimeController.text = startDateTime != null ? dateFormat.format(startDateTime) : '';
    endDateTimeController.text = endDateTime != null ? dateFormat.format(endDateTime) : '';
    setState(() {});
  }
}
