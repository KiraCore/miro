import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

typedef SearchCallback<E> = bool Function(E item, String searchValue);

class SearchOptionWidget<E> extends StatelessWidget {
  final SearchCallback<E> searchCallback;
  final void Function(String value) onChanged;

  const SearchOptionWidget({
    required this.searchCallback,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 285,
      child: SearchBar(
        label: 'Search',
        onChanged: onChanged,
        backgroundColor: DesignColors.blue1_10,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
