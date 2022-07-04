import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_event.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

class SearchOptionWidget<T extends IListItem> extends StatelessWidget {
  const SearchOptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 285,
      child: SearchBar(
        label: 'Search',
        onFieldSubmitted: (String value) {
          print('Submited: $value');
          BlocProvider.of<FilterOptionsBloc<T>>(context).add(SearchEvent<T>(value));
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
