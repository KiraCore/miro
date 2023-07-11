import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_filter_options.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_list_controller.dart';
import 'package:miro/shared/controllers/menu/proposals_page/proposals_sort_options.dart';
import 'package:miro/shared/models/proposals/proposal_model.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_item/desktop/proposal_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_item/proposal_list_item_builder.dart';
import 'package:miro/views/pages/menu/proposals_page/proposal_list_title/proposal_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list.dart';

@RoutePage()
class ProposalsPage extends StatefulWidget {
  const ProposalsPage({super.key});

  @override
  State<ProposalsPage> createState() => _ProposalsPageState();
}

class _ProposalsPageState extends State<ProposalsPage> {
  int pageSize = 10;

  final TextEditingController searchBarTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ProposalsListController proposalsListController = ProposalsListController();

  final FiltersBloc<ProposalModel> filtersBloc = FiltersBloc<ProposalModel>(
    searchComparator: ProposalsFilterOptions.search,
  );

  final SortBloc<ProposalModel> sortBloc = SortBloc<ProposalModel>(
    defaultSortOption: ProposalsSortOptions.sortById.reversed(),
  );

  @override
  void dispose() {
    searchBarTextEditingController.clear();
    scrollController.dispose();
    filtersBloc.close();
    sortBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget listHeaderWidget = ProposalListItemDesktopLayout(
      height: 64,
      idWidget: Text(S.of(context).proposalsId, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      statusWidget: Text(S.of(context).proposalsStatus, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      titleWidget: Text(S.of(context).proposalsTitle, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      tooltipWidget: const SizedBox(width: 50, height: 50),
      typesWidget: Text(S.of(context).proposalsTypes, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      votingEndWidget: Text(S.of(context).proposalsVotingEndTime, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
    );
    return CustomScrollView(controller: scrollController, slivers: <Widget>[
      SliverPadding(
        padding: AppSizes.getPagePadding(context),
        sliver: SliverPaginatedList<ProposalModel>(
          itemBuilder: (ProposalModel proposalModel) => ProposalListItemBuilder(
            proposalModel: proposalModel,
            scrollController: scrollController,
          ),
          listController: ProposalsListController(),
          scrollController: scrollController,
          singlePageSize: pageSize,
          hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
          listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
          titleBuilder: (BuildContext context) {
            return ProposalListTitle(
              pageSize: pageSize,
              filtersBloc: filtersBloc,
              pageSizeValueChanged: changePageSize,
              proposalsListController: proposalsListController,
              searchBarTextEditingController: searchBarTextEditingController,
            );
          },
          sortBloc: sortBloc,
          filtersBloc: filtersBloc,
        ),
      ),
    ]);
  }

  void changePageSize(int newSize) {
    setState(() => pageSize = newSize);
  }
}
