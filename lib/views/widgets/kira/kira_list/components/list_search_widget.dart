import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

class ListSearchWidget<T extends AListItem> extends StatefulWidget {
  final bool enabled;
  final double height;
  final double width;
  final String? hint;

  const ListSearchWidget({
    this.enabled = true,
    this.height = 50,
    this.width = 285,
    this.hint,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListSearchWidget<T>();
}

class _ListSearchWidget<T extends AListItem> extends State<ListSearchWidget<T>> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      textEditingController: textEditingController,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: DesignColors.white1,
      ),
      enabled: widget.enabled,
      height: widget.height,
      width: widget.width,
      label: widget.hint,
      backgroundColor: DesignColors.black,
      onClear: _onClearSearchBar,
      onSubmit: _onSubmitSearchBar,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: DesignColors.greyOutline),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _onClearSearchBar() {
    BlocProvider.of<FiltersBloc<T>>(context).add(FiltersSearchEvent<T>(''));
  }

  void _onSubmitSearchBar(String value) {
    BlocProvider.of<FiltersBloc<T>>(context).add(FiltersSearchEvent<T>(value));
  }
}
