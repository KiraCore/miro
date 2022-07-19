import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/a_list_state.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';

class SortIcon<T extends AListItem, B extends AListBloc<T>> extends StatelessWidget {
  final SortOption<T> sortOption;

  const SortIcon({
    required this.sortOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, AListState>(
      builder: (BuildContext context, AListState listState) {
        return Icon(
          _getIconData(context),
          size: 15,
          color: DesignColors.gray2_100,
        );
      },
    );
  }

  IconData _getIconData(BuildContext context) {
    SortOption<T> activeSortOption = BlocProvider.of<SortBloc<T>>(context).state.activeSortOption;
    if (activeSortOption.id == sortOption.id) {
      return activeSortOption.ascending ? Icons.arrow_upward : Icons.arrow_downward;
    } else {
      return AppIcons.up_down;
    }
  }
}
