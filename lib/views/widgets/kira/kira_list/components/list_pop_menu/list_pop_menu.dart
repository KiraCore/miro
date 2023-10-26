import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu_header.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu_item.dart';

class ListPopMenu<T> extends StatefulWidget {
  final bool isMultiSelect;
  final String title;
  final List<T> listItems;
  final String Function(T item) itemToString;
  final ValueChanged<T> onItemSelected;
  final Set<T>? selectedListItems;
  final VoidCallback? onClearPressed;
  final ValueChanged<T>? onItemRemoved;

  const ListPopMenu({
    required this.isMultiSelect,
    required this.title,
    required this.listItems,
    required this.itemToString,
    required this.onItemSelected,
    this.selectedListItems,
    this.onClearPressed,
    this.onItemRemoved,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListPopMenuState<T>();
}

class _ListPopMenuState<T> extends State<ListPopMenu<T>> {
  final ScrollController scrollController = ScrollController();
  late Set<T> selectedListItems;

  @override
  void initState() {
    super.initState();
    selectedListItems = widget.selectedListItems ?? <T>{};
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: const ResponsiveValue<double?>(
        largeScreen: 150,
        mediumScreen: 150,
        smallScreen: null,
      ).get(context),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListPopMenuHeader(
              title: widget.title,
              onClearPressed: widget.onClearPressed,
            ),
            const Divider(color: DesignColors.grey2),
            ...widget.listItems.map<Widget>(
              (T item) {
                if (item is Widget) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: DesignColors.grey2),
                      ),
                    ),
                    child: item,
                  );
                }
                return ListPopMenuItem(
                  title: widget.itemToString(item),
                  onTap: () => _handleItemSelected(item),
                  selected: selectedListItems.contains(item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemSelected(T item) {
    if (!widget.isMultiSelect) {
      selectedListItems.clear();
    }
    if (selectedListItems.contains(item)) {
      selectedListItems.remove(item);
      if (widget.onItemRemoved != null) {
        widget.onItemRemoved!(item);
      }
    } else {
      selectedListItems.add(item);
      widget.onItemSelected(item);
    }
    setState(() {});
  }
}
