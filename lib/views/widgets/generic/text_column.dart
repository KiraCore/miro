import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class TextColumn<T> extends StatelessWidget {
  final String Function(T item) displayItemAsString;
  final List<T>? itemList;
  final String emptyPlaceholder;

  const TextColumn({
    required this.displayItemAsString,
    this.itemList,
    this.emptyPlaceholder = '---',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    if (itemList == null || itemList!.isEmpty) {
      return Text(
        emptyPlaceholder,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (T item in itemList!)
            Text(
              displayItemAsString(item),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
            ),
        ],
      );
    }
  }
}
