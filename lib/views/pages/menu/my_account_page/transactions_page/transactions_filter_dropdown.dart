import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';

class TransactionsFilterDropdown extends StatefulWidget {
  final List<dynamic> activeFilters;
  final ValueChanged<List<dynamic>> onFiltersChanged;
  final double width;
  final Widget? mobileAdditionalWidget;

  const TransactionsFilterDropdown({
    required this.activeFilters,
    required this.onFiltersChanged,
    this.width = 100,
    this.mobileAdditionalWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TransactionsFilterDropdown();
}

class _TransactionsFilterDropdown extends State<TransactionsFilterDropdown> {
  final PopWrapperController popWrapperController = PopWrapperController();
  late Set<dynamic> activeFilters = widget.activeFilters.toSet();
  bool filtersChangedBool = false;

  @override
  void initState() {
    super.initState();
    popWrapperController.isTooltipVisibleNotifier.addListener(_handlePopMenuVisibilityChanged);
  }

  @override
  void didUpdateWidget(covariant TransactionsFilterDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    activeFilters = widget.activeFilters.toSet();
    filtersChangedBool = false;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return FilterDropdownWrapper<dynamic>(
      itemToString: _getFilterTitle,
      selectedItems: activeFilters.toList(),
      onItemRemoved: _pressChipButton,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${S.of(context).txListFiltersTitle}: ',
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
              popWrapperController: popWrapperController,
              buttonBuilder: () => FilterDropdownButton(selectedOptionsLength: activeFilters.length),
              popupBuilder: () {
                return ListPopMenu<dynamic>(
                  isMultiSelect: true,
                  itemToString: _getFilterTitle,
                  listItems: <dynamic>[
                    Text(
                      S.of(context).txListDirection,
                      style: textTheme.bodySmall!.copyWith(color: DesignColors.greenStatus1),
                    ),
                    TxDirectionType.inbound,
                    TxDirectionType.outbound,
                    Text(
                      S.of(context).txListStatus,
                      style: textTheme.bodySmall!.copyWith(color: DesignColors.greenStatus1),
                    ),
                    TxStatusType.confirmed,
                    TxStatusType.pending,
                    TxStatusType.failed,
                  ],
                  onItemSelected: _addFilterOption,
                  onItemRemoved: _removeFilterOption,
                  selectedListItems: activeFilters,
                  title: '${S.of(context).txListFiltersTitle}:',
                );
              },
            ),
          ],
        ),
        if (widget.mobileAdditionalWidget != null) ...<Widget>[
          const Spacer(),
          widget.mobileAdditionalWidget!,
        ],
      ],
    );
  }

  void _handlePopMenuVisibilityChanged() {
    bool popMenuClosedBool = popWrapperController.isTooltipVisibleNotifier.value == false;
    if (popMenuClosedBool && filtersChangedBool) {
      widget.onFiltersChanged(activeFilters.toList());
    }
  }

  void _pressChipButton(dynamic e) {
    if (activeFilters.contains(e)) {
      _removeFilterOption(e);
    }
    widget.onFiltersChanged(activeFilters.toList());
  }

  String _getFilterTitle(dynamic e) {
    switch (e) {
      case TxDirectionType.inbound:
        return S.of(context).txListDirectionInbound;
      case TxDirectionType.outbound:
        return S.of(context).txListDirectionOutbound;
      case TxStatusType.confirmed:
        return S.of(context).txListStatusConfirmed;
      case TxStatusType.pending:
        return S.of(context).txListStatusPending;
      case TxStatusType.failed:
        return S.of(context).txListStatusFailed;
      default:
        return '';
    }
  }

  void _addFilterOption(dynamic filter) {
    activeFilters.add(filter);
    filtersChangedBool = true;
    setState(() {});
  }

  void _removeFilterOption(dynamic filter) {
    activeFilters.remove(filter);
    filtersChangedBool = true;
    setState(() {});
  }
}
