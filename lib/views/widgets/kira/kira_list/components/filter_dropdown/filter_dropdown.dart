import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/a_filters_state.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class FilterDropdown<T extends AListItem> extends StatefulWidget {
  final String title;
  final List<FilterOptionModel<T>> filterOptionModels;
  final double height;
  final double width;
  final bool scrollableBool;

  const FilterDropdown({
    required this.title,
    required this.filterOptionModels,
    this.height = 30,
    this.width = 100,
    this.scrollableBool = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterDropdown<T>();
}

class _FilterDropdown<T extends AListItem> extends State<FilterDropdown<T>> {
  final PopWrapperController filterOptionsController = PopWrapperController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<FiltersBloc<T>, AFiltersState<T>>(
      builder: (BuildContext context, AFiltersState<T> filtersState) {
        List<FilterOptionModel<T>>? selectedFilterOptions = _findActiveFilters(filtersState.activeFilters);

        return FilterDropdownWrapper<FilterOptionModel<T>>(
          itemToString: (FilterOptionModel<T> item) => item.title,
          selectedItems: selectedFilterOptions,
          onItemRemoved: _removeFilterOption,
          children: <Widget>[
            Text(
              widget.title,
              style: ResponsiveValue<TextStyle>(
                largeScreen: textTheme.bodyMedium!.copyWith(
                  color: DesignColors.white2,
                ),
                smallScreen: textTheme.bodySmall!.copyWith(
                  color: DesignColors.white2,
                ),
              ).get(context),
            ),
            const SizedBox(width: 8),
            PopWrapper(
              popWrapperController: filterOptionsController,
              scrollableBool: widget.scrollableBool,
              buttonBuilder: () => FilterDropdownButton(selectedOptionsLength: selectedFilterOptions.length),
              popupBuilder: () {
                return ListPopMenu<FilterOptionModel<T>>(
                  isMultiSelect: true,
                  itemToString: (FilterOptionModel<T> item) => item.title,
                  listItems: widget.filterOptionModels,
                  onItemSelected: _addFilterOption,
                  onItemRemoved: _removeFilterOption,
                  selectedListItems: selectedFilterOptions.toSet(),
                  title: widget.title,
                );
              },
            ),
          ],
        );
      },
    );
  }

  List<FilterOptionModel<T>> _findActiveFilters(List<FilterOption<T>> filterOptions) {
    List<FilterOptionModel<T>> filterOptionModelList =
        widget.filterOptionModels.where((FilterOptionModel<T> filterOptionModel) => filterOptions.contains(filterOptionModel.filterOption)).toList();
    return filterOptionModelList;
  }

  void _addFilterOption(FilterOptionModel<T> filterOptionModel) {
    BlocProvider.of<FiltersBloc<T>>(context).add(FiltersAddOptionEvent<T>(filterOptionModel.filterOption));
  }

  void _removeFilterOption(FilterOptionModel<T> filterOptionModel) {
    BlocProvider.of<FiltersBloc<T>>(context).add(FiltersRemoveOptionEvent<T>(filterOptionModel.filterOption));
  }
}
