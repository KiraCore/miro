import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

class ListSearchWidget<T extends AListItem> extends StatelessWidget {
  final bool enabled;
  final double height;
  final String? hint;
  final double width;

  const ListSearchWidget({
    this.enabled = true,
    this.height = 50,
    this.hint,
    this.width = 285,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: SizedBox(
        height: height,
        width: width,
        child: SearchBar(
          enabled: enabled,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: DesignColors.white_100,
          ),
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
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
