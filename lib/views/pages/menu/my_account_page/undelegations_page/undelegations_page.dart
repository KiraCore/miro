import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/filters_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/undelegations_page/undelegation_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/undelegations_page/undelegations_filter_options.dart';
import 'package:miro/shared/controllers/menu/my_account_page/undelegations_page/undelegations_sort_options.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/desktop/undelegation_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/desktop/undelegation_list_item_destkop.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/undelegation_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_title/undelegation_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

class UndelegationsPage extends StatefulWidget {
  final WalletAddress walletAddress;
  final ScrollController parentScrollController;

  const UndelegationsPage({
    required this.walletAddress,
    required this.parentScrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<UndelegationsPage> createState() => _UndelegationsPageState();
}

class _UndelegationsPageState extends State<UndelegationsPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final FiltersBloc<UndelegationModel> filtersBloc = FiltersBloc<UndelegationModel>(
    searchComparator: UndelegationsFilterOptions.search,
  );
  final SortBloc<UndelegationModel> sortBloc = SortBloc<UndelegationModel>(
    defaultSortOption: UndelegationsSortOptions.sortByDate,
  );

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    filtersBloc.close();
    sortBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double listHeight = MediaQuery.of(context).size.height - 300;
    Widget listHeaderWidget = UndelegationListItemDesktopLayout(
      height: 64,
      validatorWidget: Text(S.of(context).validator, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      tokensWidget: Text(S.of(context).stakingPoolLabelTokens, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      lockedUntilWidget: Text(S.of(context).unstakedLabelLockedUntil, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
    );

    return SliverInfinityList<UndelegationModel>(
      itemBuilder: (UndelegationModel undelegationModel) => UndelegationListItemBuilder(
        key: Key(undelegationModel.toString()),
        undelegationModel: undelegationModel,
      ),
      scrollController: widget.parentScrollController,
      listController: UndelegationListController(walletAddress: widget.walletAddress),
      singlePageSize: listHeight ~/ UndelegationListItemDesktop.height + 5,
      hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
      listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
      title: UndelegationListTitle(searchBarTextEditingController: searchBarTextEditingController),
      sortBloc: sortBloc,
      filtersBloc: filtersBloc,
    );
  }
}
