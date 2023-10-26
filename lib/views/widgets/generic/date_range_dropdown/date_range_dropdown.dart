import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_range_dropdown_button.dart';
import 'package:miro/views/widgets/generic/date_range_dropdown/date_range_dropdown_pop_menu.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';

typedef DatePickerResult = void Function(DateTime? startDateTime, DateTime? endDateTime);

class DateRangeDropdown extends StatefulWidget {
  final DatePickerResult onDateTimeChanged;
  final DateTime? initialStartDateTime;
  final DateTime? initialEndDateTime;

  const DateRangeDropdown({
    required this.onDateTimeChanged,
    this.initialStartDateTime,
    this.initialEndDateTime,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateRangeDropdown();
}

class _DateRangeDropdown extends State<DateRangeDropdown> {
  final DateFormat dateFormat = DateFormat('dd.MM.yyyy');
  final PopWrapperController popWrapperController = PopWrapperController();

  late DateTime? startDateTime = widget.initialStartDateTime;
  late DateTime? endDateTime = widget.initialEndDateTime;

  @override
  Widget build(BuildContext context) {
    return PopWrapper(
      popWrapperController: popWrapperController,
      buttonBuilder: () {
        return DateRangeDropdownButton(
          startDateTime: startDateTime,
          endDateTime: endDateTime,
          onTap: popWrapperController.showTooltip,
        );
      },
      popupBuilder: () {
        return DateRangeDropdownPopMenu(
          onDateTimeChanged: _handleDateChanged,
          popWrapperController: popWrapperController,
          initialStartDateTime: startDateTime,
          initialEndDateTime: endDateTime,
        );
      },
    );
  }

  void _handleDateChanged(DateTime? startDateTime, DateTime? endDateTime) {
    this.startDateTime = startDateTime;
    this.endDateTime = endDateTime;
    widget.onDateTimeChanged(startDateTime, endDateTime);
    setState(() {});
  }
}
