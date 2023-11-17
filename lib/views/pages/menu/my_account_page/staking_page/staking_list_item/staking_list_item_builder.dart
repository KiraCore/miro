import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/mobile/staking_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class StakingListItemBuilder extends StatefulWidget {
  final ValidatorStakingModel validatorStakingModel;
  final ScrollController scrollController;

  const StakingListItemBuilder({
    required this.validatorStakingModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StakingListItemBuilder();
}

class _StakingListItemBuilder extends State<StakingListItemBuilder> {
  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = StakingListItemDesktop(
      validatorStakingModel: widget.validatorStakingModel,
    );

    Widget mobileListItem = StakingListItemMobile(
      validatorStakingModel: widget.validatorStakingModel,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }
}
