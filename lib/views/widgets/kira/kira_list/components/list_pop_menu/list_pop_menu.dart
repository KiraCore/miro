import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu_header.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu_item.dart';

class ListPopMenu<T> extends StatefulWidget {
  final bool isMultiSelect;
  final String Function(T item) itemToString;
  final List<T> listItems;
  final void Function(T item) onItemSelected;
  final String title;
  final double width;
  final double height;
  final void Function()? onClearPressed;
  final void Function(T item)? onItemRemoved;
  final Set<T>? selectedListItems;

  const ListPopMenu({
    required this.isMultiSelect,
    required this.itemToString,
    required this.listItems,
    required this.onItemSelected,
    required this.title,
    this.width = 150,
    this.height = 150,
    this.onClearPressed,
    this.onItemRemoved,
    this.selectedListItems,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListPopMenuState<T>();
}

class _ListPopMenuState<T> extends State<ListPopMenu<T>> {
  late Set<T> selectedListItems;

  @override
  void initState() {
    super.initState();
    selectedListItems = widget.selectedListItems ?? <T>{};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.zero,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListPopMenuHeader(
            title: widget.title,
            onClearPressed: widget.onClearPressed,
          ),
          ...widget.listItems.map<Widget>((T item) {
            return ListPopMenuItem(
              title: widget.itemToString(item),
              onTap: () => _handleItemSelected(item),
              selected: selectedListItems.contains(item),
            );
          }).toList(),
        ],
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
