import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/widgets/kira/kira_list/list_pop_menu/list_pop_menu_header.dart';
import 'package:miro/views/widgets/kira/kira_list/list_pop_menu/list_pop_menu_item.dart';

class ListPopMenu<T> extends StatefulWidget {
  final double width;
  final double height;
  final String title;
  final void Function()? onClearPressed;
  final List<T> items;
  final Set<T> Function()? selectedItems;
  final String Function(T item) itemToString;
  final void Function(T item) onItemSelected;
  final void Function(T item)? onItemRemoved;

  const ListPopMenu({
    required this.title,
    required this.itemToString,
    required this.onItemSelected,
    required this.items,
    this.width = 150,
    this.height = 150,
    this.onClearPressed,
    this.onItemRemoved,
    this.selectedItems,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListPopMenuState<T>();
}

class _ListPopMenuState<T> extends State<ListPopMenu<T>> {
  late Set<T> selectedOptions;

  @override
  void initState() {
    if (widget.selectedItems != null) {
      selectedOptions = widget.selectedItems!();
    } else {
      selectedOptions = <T>{};
    }
    super.initState();
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
          ...widget.items.map<Widget>((T item) {
            return ListPopMenuItem(
              title: widget.itemToString(item),
              onTap: () => _onItemSelected(item),
              selected: selectedOptions.contains(item),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _onItemSelected(T item) {
    if (selectedOptions.contains(item)) {
      selectedOptions.remove(item);
      if (widget.onItemRemoved != null) {
        widget.onItemRemoved!(item);
      }
    } else {
      selectedOptions.add(item);
      widget.onItemSelected(item);
    }
    setState(() {});
  }
}
