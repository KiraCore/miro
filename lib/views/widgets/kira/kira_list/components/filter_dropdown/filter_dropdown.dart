import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/a_filters_state.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/filters_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class FilterDropdown<T extends AListItem> extends StatefulWidget {
  final List<FilterOptionModel<T>> filterOptionModels;
  final String title;
  final double height;
  final double width;

  const FilterDropdown({
    required this.filterOptionModels,
    required this.title,
    this.height = 30,
    this.width = 100,
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

        return Row(
          children: <Widget>[
            Text(
              widget.title,
              style: ResponsiveValue<TextStyle>(
                largeScreen: textTheme.bodyText2!.copyWith(
                  color: DesignColors.gray2_100,
                ),
                smallScreen: textTheme.caption!.copyWith(
                  color: DesignColors.gray2_100,
                ),
              ).get(context),
            ),
            const ResponsiveWidget(
              largeScreen: SizedBox(width: 10),
              mediumScreen: SizedBox(width: 10),
              smallScreen: SizedBox(width: 8),
            ),
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: PopWrapper(
                buttonWidth: widget.width,
                buttonHeight: widget.height,
                popWrapperController: filterOptionsController,
                buttonBuilder: (_) => FilterDropdownButton<T>(filterOptionModelList: selectedFilterOptions),
                dropdownMargin: 0,
                decoration: BoxDecoration(
                  color: const Color(0xFF12143D),
                  borderRadius: BorderRadius.circular(8),
                ),
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
            ),
            const ResponsiveWidget(
              largeScreen: SizedBox(width: 10),
              mediumScreen: SizedBox(width: 10),
              smallScreen: SizedBox(width: 8),
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
