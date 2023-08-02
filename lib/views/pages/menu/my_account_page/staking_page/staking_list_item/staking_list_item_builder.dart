import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/shared/controllers/menu/my_account_page/staking_page/staking_model.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/desktop/staking_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/staking_page/staking_list_item/mobile/staking_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class StakingListItemBuilder extends StatefulWidget {
  final StakingModel stakingModel;
  final ScrollController scrollController;

  const StakingListItemBuilder({
    required this.stakingModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorListItemBuilder();
}

class _ValidatorListItemBuilder extends State<StakingListItemBuilder> {
  final ValueNotifier<bool> expandNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hoverNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = StakingListItemDesktop(
      stakingModel: widget.stakingModel,
      onFavouriteButtonPressed: _onFavouriteButtonPressed,
    );

    Widget mobileListItem = StakingListItemMobile(
      stakingModel: widget.stakingModel,
      onFavouriteButtonPressed: _onFavouriteButtonPressed,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }

  Future<void> _onFavouriteButtonPressed(bool status) async {
    FavouritesBloc<StakingModel> favouritesBloc = BlocProvider.of<FavouritesBloc<StakingModel>>(context);

    await widget.scrollController.animateTo(
      widget.scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );

    if (widget.stakingModel.isFavourite) {
      favouritesBloc.add(FavouritesRemoveRecordEvent<StakingModel>(widget.stakingModel));
    } else {
      favouritesBloc.add(FavouritesAddRecordEvent<StakingModel>(widget.stakingModel));
    }
  }
}
