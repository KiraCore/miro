import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_bloc.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/utils/list/i_list_item.dart';
import 'package:miro/shared/utils/list/sort_option.dart';

class SortIcon<T extends IListItem> extends StatelessWidget {
  final SortOption<T> sortOption;

  const SortIcon({
    required this.sortOption,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    SortOption<T> activeSortOption = BlocProvider.of<SortOptionBloc<T>>(context).state.activeSortOption;
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
