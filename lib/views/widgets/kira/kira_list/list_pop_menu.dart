import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

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
          _PopupHeader(
            title: widget.title,
            onClearPressed: widget.onClearPressed,
          ),
          ...widget.items.map<Widget>((T item) {
            return _ListItem(
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

class _PopupHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onClearPressed;

  const _PopupHeader({
    required this.title,
    this.onClearPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
      trailing: onClearPressed == null
          ? null
          : IconButton(
              icon: const Text('Clear'),
              onPressed: onClearPressed,
            ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool selected;

  const _ListItem({
    required this.onTap,
    required this.title,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(color: DesignColors.gray2_100, fontSize: 14),
      ),
      trailing: selected
          ? const Icon(
              AppIcons.done,
              color: DesignColors.blue1_100,
              size: 12,
            )
          : null,
    );
  }
}
