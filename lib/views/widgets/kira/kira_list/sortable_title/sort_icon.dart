import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/list/sort_option.dart';

class SortIcon<ItemType, ListBlocType extends ListBloc<ItemType>> extends StatelessWidget {
  final SortOption<ItemType> sortOption;

  const SortIcon({
    required this.sortOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    SortOption<ItemType> activeSortOption = BlocProvider.of<ListBlocType>(context).activeSortOption;
    if (activeSortOption.id == sortOption.id) {
      iconData = activeSortOption.ascending ? Icons.arrow_upward : Icons.arrow_downward;
    } else {
      iconData = AppIcons.up_down;
    }

    return Icon(
      iconData,
      size: 15,
      color: DesignColors.gray2_100,
    );
  }
}
