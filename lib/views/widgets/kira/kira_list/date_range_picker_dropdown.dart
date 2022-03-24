import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/utils/date_time_utils.dart';
import 'package:miro/views/widgets/buttons/kira_elevated_button.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/fake_text_field.dart';
import 'package:miro/views/widgets/generic/calendar_range_picker.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pretty_input.dart';

typedef DatePickedCallback = void Function(DateTime? from, DateTime? to);

const double _kDropdownButtonWidth = 280;
const double _kDropdownButtonHeight = 48;

class DateRangePickerDropdown extends StatefulWidget {
  final DatePickedCallback onDatePicked;

  const DateRangePickerDropdown({
    required this.onDatePicked,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateRangePickerDropdown();
}

class _DateRangePickerDropdown extends State<DateRangePickerDropdown> {
  PopWrapperController popWrapperController = PopWrapperController();
  CalendarRangePickerController calendarController = CalendarRangePickerController();

  DateTime? _confirmedStartDate;
  DateTime? _confirmedEndDate;

  @override
  Widget build(BuildContext context) {
    return PopWrapper(
      popWrapperController: popWrapperController,
      buttonWidth: _kDropdownButtonWidth,
      buttonHeight: _kDropdownButtonHeight,
      buttonBuilder: (AnimationController animationController) {
        return Row(
          children: <Widget>[
            Expanded(
              child: _DatePickerCell(
                label: 'Start Date',
                dateTime: _confirmedStartDate,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DatePickerCell(
                label: 'End Date',
                dateTime: _confirmedEndDate,
              ),
            ),
          ],
        );
      },
      decoration: BoxDecoration(
        color: const Color(0xFF12143D),
        borderRadius: BorderRadius.circular(8),
      ),
      popupBuilder: () {
        return _DatePickerPopup(
          calendarController: calendarController,
          popWrapperController: popWrapperController,
          datePickedCallback: _onDatePicked,
          initialDateStart: _confirmedStartDate,
          initialDateEnd: _confirmedEndDate,
        );
      },
    );
  }

  void _onDatePicked(DateTime? from, DateTime? to) {
    setState(() {
      _confirmedStartDate = from;
      _confirmedEndDate = to;
    });
    widget.onDatePicked(from, to);
  }
}

class _DatePickerCell extends StatelessWidget {
  final DateTime? dateTime;
  final String label;

  const _DatePickerCell({
    required this.label,
    this.dateTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? text = _parseDateToText();
    return PrettyInput(
      color: DesignColors.blue1_10,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FakeTextField(
          value: text,
          label: label,
          icon: const Icon(
            AppIcons.calendar,
            size: 18,
            color: DesignColors.blue1_100,
          ),
        ),
      ),
    );
  }

  String? _parseDateToText() {
    if (dateTime == null) {
      return null;
    }
    return DateFormat('dd.MM.yyyy').format(dateTime!);
  }
}

const EdgeInsets _kDatePickerHorizontalPadding = EdgeInsets.symmetric(horizontal: 20);
const EdgeInsets _kDatePickerVerticalPadding = EdgeInsets.symmetric(vertical: 17);
const double _kPopupHeight = 400;
const double _kPopupWidth = 280;

class _DatePickerPopup extends StatefulWidget {
  final DateTime? initialDateStart;
  final DateTime? initialDateEnd;
  final CalendarRangePickerController calendarController;
  final PopWrapperController popWrapperController;
  final void Function(DateTime? from, DateTime? to) datePickedCallback;

  const _DatePickerPopup({
    required this.initialDateStart,
    required this.initialDateEnd,
    required this.popWrapperController,
    required this.calendarController,
    required this.datePickedCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatePickerPopupState();
}

class _DatePickerPopupState extends State<_DatePickerPopup> {
  final TextEditingController _startDateTextController = TextEditingController();
  final TextEditingController _endDateTextController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    _onDateSelectionChanged(widget.initialDateStart, widget.initialDateEnd, notify: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _kPopupWidth,
      height: _kPopupHeight,
      padding: _kDatePickerVerticalPadding,
      child: Column(
        children: <Widget>[
          Padding(
            padding: _kDatePickerHorizontalPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _ClearButton(
                  onTap: _onClear,
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          _DateShortcutsToolbar(
            startDate: _startDate,
            endDate: _endDate,
            onDateRangeSelected: (DateTimeRange dateTimeRange) {
              widget.calendarController.setRange(dateTimeRange.start, dateTimeRange.end);
            },
          ),
          const SizedBox(height: 14),
          _ManualDatePicker(
            startDateTextController: _startDateTextController,
            endDateTextController: _endDateTextController,
            onStartDateChanged: (DateTime dateTime) {
              setState(() {
                _startDate = dateTime;
                widget.calendarController.setStartDate(dateTime);
              });
            },
            onEndDateChanged: (DateTime dateTime) {
              setState(() {
                _endDate = dateTime;
                widget.calendarController.setEndDate(dateTime);
              });
            },
          ),
          Expanded(
            child: CalendarDateRangePicker(
              controller: widget.calendarController,
              firstDate: DateTime(1, 1, 2015),
              lastDate: DateTime.now().add(const Duration(days: 365)),
              onDateChanged: _onDateSelectionChanged,
              initialDateFrom: _startDate ?? DateTime.now(),
              initialDateTo: _endDate,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: KiraOutlinedButton(
                    onPressed: _onCancel,
                    title: 'Cancel',
                    height: 30,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: KiraElevatedButton(
                    onPressed: _onSubmit,
                    title: 'Ok',
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onClear() {
    _onDateSelectionChanged(null, null);
    widget.calendarController.setRange(DateTime.now(), null, notify: false);
  }

  void _onDateSelectionChanged(DateTime? start, DateTime? end, {bool notify = true}) {
    _startDate = start;
    _startDateTextController.text = _parseDateToText(start) ?? '';
    _endDate = end;
    _endDateTextController.text = _parseDateToText(end) ?? '';

    if (notify) {
      setState(() {});
    }
  }

  String? _parseDateToText(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  void _onCancel() {
    _onClear();
    widget.popWrapperController.hideMenu();
  }

  void _onSubmit() {
    widget.popWrapperController.hideMenu();
    widget.datePickedCallback(_startDate, _endDate = _endDate ?? _startDate);
  }
}

class _ClearButton extends StatelessWidget {
  final GestureTapCallback onTap;

  const _ClearButton({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 12,
            color: DesignColors.white_100,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

const double _kDateShortcutsToolbarHeight = 30;

class _DateShortcutsToolbar extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final void Function(DateTimeRange) onDateRangeSelected;

  const _DateShortcutsToolbar({
    required this.startDate,
    required this.endDate,
    required this.onDateRangeSelected,
    Key? key,
  }) : super(key: key);

  bool get isToday {
    return DateTimeUtils.isToday(startDate) && DateTimeUtils.isToday(startDate);
  }

  bool get isLastWeek {
    return DateTimeUtils.isLastWeek(startDate, endDate);
  }

  bool get isLastMonth {
    return DateTimeUtils.isLastMonth(startDate, endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kDateShortcutsToolbarHeight,
      padding: _kDatePickerHorizontalPadding,
      child: Row(
        children: <Widget>[
          _DatePickerChip(
            selected: isToday,
            label: 'Today',
            onTap: () => _onRangeSelected(DateTime.now(), DateTime.now()),
          ),
          const SizedBox(width: 8),
          _DatePickerChip(
            selected: isLastWeek,
            label: '1 week',
            onTap: () => _onRangeSelected(DateTime.now().subtract(const Duration(days: 7)), DateTime.now()),
          ),
          const SizedBox(width: 8),
          _DatePickerChip(
            selected: isLastMonth,
            label: '1 month',
            onTap: () => _onRangeSelected(DateTime.now().subtract(const Duration(days: 30)), DateTime.now()),
          ),
        ],
      ),
    );
  }

  void _onRangeSelected(DateTime start, DateTime end) {
    onDateRangeSelected(DateTimeRange(start: start, end: end));
  }
}

class _DatePickerChip extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function() onTap;

  const _DatePickerChip({
    required this.label,
    required this.onTap,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            color: selected ? DesignColors.blue1_100 : Colors.transparent,
            border: Border.all(
              color: selected ? DesignColors.blue1_100 : DesignColors.gray2_100,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: DesignColors.white_100,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const double _kManualDatePickerHeight = 34;

class _ManualDatePicker extends StatelessWidget {
  final TextEditingController startDateTextController;
  final TextEditingController endDateTextController;
  final ValueChanged<DateTime> onStartDateChanged;
  final ValueChanged<DateTime> onEndDateChanged;

  const _ManualDatePicker({
    required this.startDateTextController,
    required this.endDateTextController,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kManualDatePickerHeight,
      padding: _kDatePickerHorizontalPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _DatePickerTextField(
              controller: startDateTextController,
              onDateChanged: onStartDateChanged,
            ),
          ),
          const SizedBox(
            width: 15,
            child: Center(
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 14,
                  color: DesignColors.gray2_100,
                ),
              ),
            ),
          ),
          Expanded(
            child: _DatePickerTextField(
              controller: endDateTextController,
              onDateChanged: onEndDateChanged,
            ),
          )
        ],
      ),
    );
  }
}

class _DatePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(DateTime) onDateChanged;

  const _DatePickerTextField({
    required this.controller,
    required this.onDateChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder defaultBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: DesignColors.gray2_100,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    );

    return TextFormField(
      controller: controller,
      onChanged: _onDateChanged,
      decoration: InputDecoration(
        hintText: 'DD/MM/YYYY',
        hintStyle: const TextStyle(
          color: DesignColors.gray2_100,
          fontSize: 14,
        ),
        focusedBorder: defaultBorder.copyWith(
          borderSide: const BorderSide(
            color: DesignColors.blue1_100,
            width: 1,
          ),
        ),
        border: defaultBorder,
        focusedErrorBorder: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
      ),
    );
  }

  void _onDateChanged(String dateText) {
    List<String> dateParts = dateText.split('/');
    if (dateParts.length != 3) {
      return;
    }
    int? day = int.tryParse(dateParts[0]);
    int? month = int.tryParse(dateParts[1]);
    int? year = int.tryParse(dateParts[2]);
    if (day == null || month == null || year == null) {
      return;
    }
    if (month > 12 || year < 1000) {
      return;
    }
    DateTime dateTime = DateTime(year, month, day);
    onDateChanged(dateTime);
  }
}
