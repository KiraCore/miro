import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/proposal_status.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_value.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_button.dart';
import 'package:miro/views/widgets/kira/kira_list/components/filter_dropdown/filter_dropdown_wrapper.dart';
import 'package:miro/views/widgets/kira/kira_list/components/list_pop_menu/list_pop_menu.dart';

class ProposalsFilterDropdown extends StatefulWidget {
  final List<dynamic> activeFilters;
  final ValueChanged<List<dynamic>> onFiltersChanged;
  final MainAxisAlignment mainAxisAlignment;
  final double width;
  final Widget? mobileAdditionalWidget;

  const ProposalsFilterDropdown({
    required this.activeFilters,
    required this.onFiltersChanged,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.width = 100,
    this.mobileAdditionalWidget,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProposalsFilterDropdown();
}

class _ProposalsFilterDropdown extends State<ProposalsFilterDropdown> {
  final PopWrapperController popWrapperController = PopWrapperController();
  late Set<dynamic> activeFilters = widget.activeFilters.toSet();
  bool filtersChangedBool = false;

  @override
  void initState() {
    super.initState();
    popWrapperController.isTooltipVisibleNotifier.addListener(_handlePopMenuVisibilityChanged);
  }

  @override
  void didUpdateWidget(covariant ProposalsFilterDropdown oldWidget) {
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
      mainAxisAlignment: widget.mainAxisAlignment,
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
                      S.of(context).txListStatus,
                      style: textTheme.bodySmall!.copyWith(color: DesignColors.greenStatus1),
                    ),
                    ProposalStatus.enactment,
                    ProposalStatus.passed,
                    ProposalStatus.passedWithExecFail,
                    ProposalStatus.pending,
                    ProposalStatus.quorumNotReached,
                    ProposalStatus.rejected,
                    ProposalStatus.rejectedWithVeto,
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
      case ProposalStatus.enactment:
        return 'Enactment';
      case ProposalStatus.passed:
        return 'Passed';
      case ProposalStatus.passedWithExecFail:
        return 'Passed with exec fail';
      case ProposalStatus.pending:
        return 'Pending';
      case ProposalStatus.quorumNotReached:
        return 'Quorum not reached';
      case ProposalStatus.rejected:
        return 'Rejected';
      case ProposalStatus.rejectedWithVeto:
        return 'Rejected With Veto';
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
