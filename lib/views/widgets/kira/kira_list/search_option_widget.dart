import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/search_event.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/search_bar.dart';

class SearchOptionWidget<ListItemType, ListBlocType extends ListBloc<dynamic>> extends StatelessWidget {
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
          BlocProvider.of<ListBlocType>(context).add(SearchEvent<ListItemType>(value));
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
