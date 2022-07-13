import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

const double kDefaultSearchBarWidth = 285;
const double kDefaultSearchBarHeight = 50;

class ListSearchWidget<T extends AListItem> extends StatelessWidget {
  final String? hint;
  final double? width;

  const ListSearchWidget({
    this.hint,
    this.width = kDefaultSearchBarWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDefaultSearchBarHeight,
      width: width,
      child: SearchBar(
        label: hint,
        onFieldSubmitted: (String value) {
          BlocProvider.of<FiltersBloc<T>>(context).add(FiltersSearchEvent<T>(value));
        },
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
