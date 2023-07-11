import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/kira_filter_chip.dart';

class FilterDropdownWrapper<T> extends StatelessWidget {
  final List<Widget> children;
  final List<T> selectedItems;
  final String Function(T item) itemToString;
  final ValueChanged<T> onItemRemoved;
  final MainAxisAlignment mainAxisAlignment;

  const FilterDropdownWrapper({
    required this.children,
    required this.selectedItems,
    required this.itemToString,
    required this.onItemRemoved,
    this.mainAxisAlignment = MainAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget dropdownWidget = Row(
      mainAxisAlignment: mainAxisAlignment,
      children: children,
    );

    List<Widget> filtersWidgets = selectedItems.map((T item) {
      return KiraFilterChip(
        title: itemToString(item),
        textTheme: textTheme,
        onTap: () => onItemRemoved(item),
        size: 10,
      );
    }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: ResponsiveWidget.isLargeScreen(context) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        dropdownWidget,
        if (selectedItems.isNotEmpty) ...<Widget>[
          if (ResponsiveWidget.isLargeScreen(context)) const SizedBox(height: 8) else const SizedBox(height: 14),
          Wrap(spacing: 8, runSpacing: 8, children: filtersWidgets),
        ],
      ],
    );
  }
}
