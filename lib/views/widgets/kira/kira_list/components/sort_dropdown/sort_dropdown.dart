import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_state.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sort_dropdown/sort_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

const double kDefaultButtonHeight = 30;
const double kDefaultButtonWidth = 100;

class SortDropdown<T extends AListItem> extends StatefulWidget {
  final List<SortOptionModel<T>> sortOptionModels;

  const SortDropdown({
    required this.sortOptionModels,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SortDropdown<T>();
}

class _SortDropdown<T extends AListItem> extends State<SortDropdown<T>> {
  PopWrapperController sortOptionsController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SortBloc<T>, SortState<T>>(
      builder: (BuildContext context, SortState<T> sortState) {
        SortOptionModel<T> selectedSortOptionModel = _findSortOptionModel(sortState.activeSortOption);
        return Row(
          children: <Widget>[
            Text(
              'Sort by',
              style: textTheme.bodyText2!.copyWith(
                color: DesignColors.gray2_100,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: kDefaultButtonWidth,
              height: kDefaultButtonHeight,
              child: PopWrapper(
                buttonWidth: kDefaultButtonWidth,
                buttonHeight: kDefaultButtonHeight,
                popWrapperController: sortOptionsController,
                buttonBuilder: (_) => SortDropdownButton<T>(sortOptionModel: selectedSortOptionModel),
                dropdownMargin: 0,
                decoration: BoxDecoration(
                  color: const Color(0xFF12143D),
                  borderRadius: BorderRadius.circular(8),
                ),
                popupBuilder: () {
                  return ListPopMenu<SortOptionModel<T>>(
                    isMultiSelect: false,
                    itemToString: (SortOptionModel<T> item) => item.title,
                    listItems: widget.sortOptionModels,
                    onItemSelected: _changeCurrentSortOption,
                    selectedListItems: <SortOptionModel<T>>{selectedSortOptionModel},
                    title: 'Sort by',
                  );
                },
              ),
            ),
            Opacity(
              opacity: 1,
              child: IconButton(
                onPressed: () => _reverseCurrentSortOption(selectedSortOptionModel),
                splashRadius: 20,
                icon: const Icon(
                  AppIcons.up_down,
                  size: 16,
                  color: DesignColors.gray2_100,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  SortOptionModel<T> _findSortOptionModel(SortOption<T> sortOption) {
    SortOptionModel<T> sortOptionModel = widget.sortOptionModels.firstWhere(
      (SortOptionModel<T> sortOptionModel) => sortOptionModel.sortOption == sortOption,
      orElse: () => SortOptionModel<T>(title: 'Error', sortOption: sortOption),
    );
    return sortOptionModel.copyWith(
      sortOption: sortOption,
    );
  }

  void _changeCurrentSortOption(SortOptionModel<T> sortOptionModel) {
    sortOptionsController.hideMenu();
    setState(() {});
    BlocProvider.of<SortBloc<T>>(context).add(SortChangeEvent<T>(sortOption: sortOptionModel.sortOption));
  }

  void _reverseCurrentSortOption(SortOptionModel<T> sortOptionModel) {
    BlocProvider.of<SortBloc<T>>(context).add(SortChangeEvent<T>(sortOption: sortOptionModel.sortOption.reversed()));
  }
}
