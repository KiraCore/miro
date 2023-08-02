import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_list_controller.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_model.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/staking_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_title/staking_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

class StakingPage extends StatefulWidget {
  const StakingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingPage();
}

class _StakingPage extends State<StakingPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final StakingListController stakingListController = StakingListController();

  late final FavouritesBloc<StakingModel> favouritesBloc = FavouritesBloc<StakingModel>(
    listController: stakingListController,
  );

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double listHeight = MediaQuery.of(context).size.height - 300;
    Widget listHeaderWidget = StakingListItemDesktopLayout(
      height: 64,
      infoButtonWidget: const SizedBox(),
      validatorWidget: Text(S.of(context).validator, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      statusWidget: Text(S.of(context).validatorsTableStatus, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      tokensWidget: Text(S.of(context).stakingPoolLabelTokens, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
      commissionWidget: Text(S.of(context).stakingPoolLabelCommission, style: textTheme.caption!.copyWith(color: DesignColors.white1)),
    );

    return SliverInfinityList<StakingModel>(
      itemBuilder: (StakingModel stakingModel) => StakingListItemBuilder(
        key: Key(stakingModel.toString()),
        stakingModel: stakingModel,
        scrollController: scrollController,
      ),
      listController: StakingListController(),
      scrollController: scrollController,
      singlePageSize: listHeight ~/ StakingListItemDesktop.height + 5,
      hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
      listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
      title: StakingListTitle(searchBarTextEditingController: searchBarTextEditingController),
      favouritesBloc: favouritesBloc,
    );
  }
}
