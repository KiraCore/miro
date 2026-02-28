import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/blocks/blocks_page/blocks_page_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_filter_options.dart';
import 'package:miro/shared/controllers/menu/blocks_page/blocks_list_controller.dart';
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
  int pageSize = 15;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final BlocksListController listController = BlocksListController();
  final FiltersBloc<BlockModel> filtersBloc = FiltersBloc<BlockModel>(
    searchComparator: BlocksFilterOptions.search,
  );

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    scrollController.dispose();
    filtersBloc.close();
    super.dispose();
  }

  void changePageSize(int newSize) {
    setState(() {
      pageSize = newSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle headerStyle = textTheme.bodySmall!.copyWith(color: DesignColors.white1);

    return BlocProvider<BlocksPageCubit>(
      create: (BuildContext context) => BlocksPageCubit(),
      child: BlocBuilder<BlocksPageCubit, BlocksPageState>(
        builder: (BuildContext context, BlocksPageState state) {
          Widget listHeaderWidget = BlocksListItemDesktopLayout(
            height: 64,
            hashWidget: Text(S.of(context).blocksHash, style: headerStyle),
            ageWidget: InkWell(
              onTap: () => context.read<BlocksPageCubit>().switchDateFormat(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  state.isAgeFormatBool ? S.of(context).blocksAge : S.of(context).blocksDate,
                  style: headerStyle.copyWith(color: DesignColors.hyperlink),
                ),
              ),
            ),
            isDateInAgeFormatBool: state.isAgeFormatBool,
            heightWidget: Text(S.of(context).blocksHeight, style: headerStyle),
            proposerWidget: Text(S.of(context).blocksProposer, style: headerStyle),
            txCountWidget: Text(S.of(context).blocksTxCount, style: headerStyle),
          );

          return CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverPadding(
                padding: AppSizes.getPagePadding(context),
                sliver: SliverPaginatedList<BlockModel>(
                  itemBuilder: (BlockModel blockModel) => BlocksListItemBuilder(
                    key: ValueKey<String>(blockModel.blockId.hash),
                    blockModel: blockModel,
                    scrollController: scrollController,
                    isAgeFormatBool: state.isAgeFormatBool,
                  ),
                  desktopItemHeight: BlockListTitleDesktop.height.toInt(),
                  listController: listController,
                  scrollController: scrollController,
                  singlePageSize: pageSize,
                  hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
                  listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
                  titleBuilder: (_) => BlockListTile(
                    pageSize: pageSize,
                    pageSizeValueChanged: changePageSize,
                    searchBarTextEditingController: searchBarTextEditingController,
                    blocksListController: listController,
                  ),
                  filtersBloc: filtersBloc,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
