import 'package:flutter/material.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_list_controller.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/staking_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_title/staking_list_title.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/kira/kira_list/infinity_list/sliver_infinity_list/sliver_infinity_list.dart';

class StakingPage extends StatefulWidget {
  final WalletAddress walletAddress;

  const StakingPage({
    required this.walletAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingPage();
}

class _StakingPage extends State<StakingPage> {
  final TextEditingController searchBarTextEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  late final StakingListController stakingListController = StakingListController(delegatorAddress: widget.walletAddress.bech32Address);
  late final FavouritesBloc<ValidatorStakingModel> favouritesBloc = FavouritesBloc<ValidatorStakingModel>(
    listController: stakingListController,
  );

  @override
  void dispose() {
    searchBarTextEditingController.dispose();
    scrollController.dispose();
    favouritesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double listHeight = MediaQuery.of(context).size.height - 300;
    Widget listHeaderWidget = StakingListItemDesktopLayout(
      height: 64,
      infoButtonWidget: const SizedBox(),
      validatorWidget: Text(S.of(context).validator, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      statusWidget: Text(S.of(context).validatorsTableStatus, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      tokensWidget: Text(S.of(context).stakingPoolLabelTokens, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
      commissionWidget: Text(S.of(context).stakingPoolLabelCommission, style: textTheme.bodySmall!.copyWith(color: DesignColors.white1)),
    );

    return SliverInfinityList<ValidatorStakingModel>(
      itemBuilder: (ValidatorStakingModel validatorStakingModel) => StakingListItemBuilder(
        key: Key(validatorStakingModel.toString()),
        validatorStakingModel: validatorStakingModel,
        scrollController: scrollController,
      ),
      listController: stakingListController,
      scrollController: scrollController,
      singlePageSize: listHeight ~/ StakingListItemDesktop.height + 5,
      hasBackgroundBool: ResponsiveWidget.isLargeScreen(context),
      listHeaderWidget: ResponsiveWidget.isLargeScreen(context) ? listHeaderWidget : null,
      title: StakingListTitle(searchBarTextEditingController: searchBarTextEditingController),
      favouritesBloc: favouritesBloc,
    );
  }
}
