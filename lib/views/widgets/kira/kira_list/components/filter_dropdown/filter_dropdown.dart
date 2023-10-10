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
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/kira_filter_chip.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/models/filter_option_model.dart';

class FilterDropdown<T extends AListItem> extends StatefulWidget {
  final String title;
  final List<FilterOptionModel<T>> filterOptionModels;
  final double height;
  final double width;

  const FilterDropdown({
    required this.title,
    required this.filterOptionModels,
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

        return Column(
          crossAxisAlignment: const ResponsiveValue<CrossAxisAlignment>(
            largeScreen: CrossAxisAlignment.end,
            mediumScreen: CrossAxisAlignment.start,
            smallScreen: CrossAxisAlignment.start,
          ).get(context),
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              spacing: const ResponsiveValue<double>(
                largeScreen: 8,
                mediumScreen: 12,
                smallScreen: 12,
              ).get(context),
              runSpacing: const ResponsiveValue<double>(
                largeScreen: 8,
                mediumScreen: 10,
                smallScreen: 10,
              ).get(context),
              crossAxisAlignment: WrapCrossAlignment.center,
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
                PopWrapper(
                  popWrapperController: filterOptionsController,
                  buttonBuilder: () => FilterDropdownButton<T>(filterOptionModelList: selectedFilterOptions),
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
                if (ResponsiveWidget.isSmallScreen(context) || ResponsiveWidget.isMediumScreen(context)) ...<Widget>[
                  for (int index = 0; index < selectedFilterOptions.length; index++)
                    KiraFilterChip(
                      title: selectedFilterOptions[index].title,
                      textTheme: textTheme,
                      onTap: () => _removeFilterOption(selectedFilterOptions[index]),
                      size: 12,
                    ),
                ],
              ],
            ),
            if (ResponsiveWidget.isLargeScreen(context) && selectedFilterOptions.isNotEmpty) ...<Widget>[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                children: <Widget>[
                  for (int index = 0; index < selectedFilterOptions.length; index++)
                    KiraFilterChip(
                      title: selectedFilterOptions[index].title,
                      textTheme: textTheme,
                      onTap: () => _removeFilterOption(selectedFilterOptions[index]),
                      size: 10,
                    ),
                ],
              )
            ],
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
