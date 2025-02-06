import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_filter_options.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_list_controller.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_sort_options.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_item/blocks_list_item_builder.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_item/desktop/blocks_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_title/blocks_list_title.dart';
import 'package:miro/views/pages/menu/blocks_page/blocks_list_title/blocks_list_title_desktop.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/sliver_paginated_list/sliver_paginated_list.dart';

@RoutePage()
class BlocksPage extends StatefulWidget {
  const BlocksPage({super.key});

  @override
  State<BlocksPage> createState() => _BlocksPageState();
}

class _BlocksPageState extends State<BlocksPage> {
  int pageSize = 10;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchBarTextEditingController = TextEditingController();

  void changePageSize(int newSize) {
    setState(() {
      pageSize = newSize;
    });
  }

  final FiltersBloc<BlockModel> filtersBloc = FiltersBloc<BlockModel>(
    searchComparator: BlocksFilterOptions.search,
  );

  final SortBloc<BlockModel> sortBloc = SortBloc<BlockModel>(
    defaultSortOption: BlocksSortOptions.sortByHeight.reversed(),
  );
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Widget listHeaderWidget = BlocksListItemDesktopLayout(
      height: 64,
      ageWidget: Text(S.of(context).blocksDateTime, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      hashWidget: Text(S.of(context).blocksHash, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      heightWidget: Text(S.of(context).blocksHeight, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      kiraToolTipWidget: const SizedBox(width: 50),
      proposerWidget: Text(S.of(context).blocksProposer, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      txCountWidget: Text(S.of(context).blocksTxCount, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
    );
    return CustomScrollView(controller: scrollController, slivers: <Widget>[
      SliverPadding(
        padding: AppSizes.getPagePadding(context),
        sliver: SliverPaginatedList<BlockModel>(
          itemBuilder: (BlockModel blockModel) => BlocksListItemBuilder(
            blockModel: blockModel,
            scrollController: scrollController,
          ),
          desktopItemHeight: BlockListTitleDesktop.height.toInt(),
          listController: BlocksListController(),
          scrollController: scrollController,
          singlePageSize: pageSize,
          hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
          listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
          titleBuilder: (_) => BlockListTile(
            pageSize: pageSize,
            pageSizeValueChanged: changePageSize,
            searchBarTextEditingController: searchBarTextEditingController,
          ),
          sortBloc: sortBloc,
          filtersBloc: filtersBloc,
        ),
      ),
    ]);
  }
}
