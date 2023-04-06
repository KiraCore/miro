import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/sort/sort_state.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';
import 'package:miro/views/widgets/kira/kira_list/components/sort_dropdown/sort_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option_model.dart';

class SortDropdown<T extends AListItem> extends StatefulWidget {
  final List<SortOptionModel<T>> sortOptionModels;
  final double height;
  final double width;

  const SortDropdown({
    required this.sortOptionModels,
    this.height = 30,
    this.width = 100,
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
              S.of(context).sortBy,
              style: ResponsiveValue<TextStyle>(
                largeScreen: textTheme.bodyText2!.copyWith(
                  color: DesignColors.white2,
                ),
                smallScreen: textTheme.caption!.copyWith(
                  color: DesignColors.white2,
                ),
              ).get(context),
            ),
            const ResponsiveWidget(
              largeScreen: SizedBox(width: 10),
              mediumScreen: SizedBox(width: 10),
              smallScreen: SizedBox(width: 8),
            ),
            PopWrapper(
              buttonSize: Size(widget.width, widget.height),
              popWrapperController: sortOptionsController,
              buttonBuilder: () => SortDropdownButton<T>(sortOptionModel: selectedSortOptionModel),
              popupBuilder: () {
                return ListPopMenu<SortOptionModel<T>>(
                  isMultiSelect: false,
                  itemToString: (SortOptionModel<T> item) => item.title,
                  listItems: widget.sortOptionModels,
                  onItemSelected: _changeCurrentSortOption,
                  selectedListItems: <SortOptionModel<T>>{selectedSortOptionModel},
                  title: S.of(context).sortBy,
                );
              },
            ),
            const ResponsiveWidget(
              largeScreen: SizedBox(width: 10),
              mediumScreen: SizedBox(width: 10),
              smallScreen: SizedBox(width: 8),
            ),
            InkWell(
              onTap: () => _reverseCurrentSortOption(selectedSortOptionModel),
              child: const Icon(
                AppIcons.up_down,
                size: 16,
                color: DesignColors.white2,
              ),
            ),
          ],
        );
      },
    );
  }

  SortOptionModel<T> _findSortOptionModel(SortOption<T> sortOption) {
    SortOptionModel<T> sortOptionModel = widget.sortOptionModels.firstWhere(
      (SortOptionModel<T> sortOptionModel) => sortOptionModel.sortOption == sortOption,
      orElse: () => SortOptionModel<T>(title: S.of(context).error, sortOption: sortOption),
    );
    return sortOptionModel.copyWith(
      sortOption: sortOption,
    );
  }

  void _changeCurrentSortOption(SortOptionModel<T> sortOptionModel) {
    sortOptionsController.hideTooltip();
    setState(() {});
    BlocProvider.of<SortBloc<T>>(context).add(SortChangeEvent<T>(sortOption: sortOptionModel.sortOption));
  }

  void _reverseCurrentSortOption(SortOptionModel<T> sortOptionModel) {
    BlocProvider.of<SortBloc<T>>(context).add(SortChangeEvent<T>(sortOption: sortOptionModel.sortOption.reversed()));
  }
}
