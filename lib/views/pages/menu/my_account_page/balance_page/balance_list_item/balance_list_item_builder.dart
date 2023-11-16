import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/events/list_reload_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/favourites/favourites_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/infinity_list/infinity_list_bloc.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/balance_list_item_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/desktop/balance_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/mobile/balance_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class BalanceListItemBuilder extends StatefulWidget {
  final BalanceModel balanceModel;
  final ScrollController scrollController;

  const BalanceListItemBuilder({
    required this.balanceModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BalanceListItemBuilder();
}

class _BalanceListItemBuilder extends State<BalanceListItemBuilder> {
  final ValueNotifier<bool> expandNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hoverNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    expandNotifier.dispose();
    hoverNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BalanceListItemLayout(
      expandNotifier: expandNotifier,
      hoverNotifier: hoverNotifier,
      itemContent: ResponsiveWidget(
        largeScreen: BalanceListItemDesktop(
          balanceModel: widget.balanceModel,
          expansionChangedCallback: _onExpansionChanged,
          favouritePressedCallback: _onFavouriteButtonPressed,
          onSendButtonPressed: _handleSendButtonPressed,
          hoverNotifier: hoverNotifier,
        ),
        mediumScreen: BalanceListItemMobile(
          balanceModel: widget.balanceModel,
          expansionChangedCallback: _onExpansionChanged,
          favouritePressedCallback: _onFavouriteButtonPressed,
          hoverNotifier: hoverNotifier,
          onSendButtonPressed: _handleSendButtonPressed,
        ),
      ),
    );
  }

  void _onExpansionChanged(bool status) {
    expandNotifier.value = status;
  }

  Future<void> _onFavouriteButtonPressed(bool status) async {
    await widget.scrollController.animateTo(
      widget.scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );

    FavouritesBloc<BalanceModel> favouritesBloc = BlocProvider.of<FavouritesBloc<BalanceModel>>(context);
    if (widget.balanceModel.isFavourite) {
      favouritesBloc.add(FavouritesRemoveRecordEvent<BalanceModel>(widget.balanceModel));
    } else {
      favouritesBloc.add(FavouritesAddRecordEvent<BalanceModel>(widget.balanceModel));
    }
  }

  Future<void> _handleSendButtonPressed() async {
    await KiraRouter.of(context).push<void>(TransactionsWrapperRoute(
      children: <PageRouteInfo>[
        TxSendTokensRoute(defaultBalanceModel: widget.balanceModel),
      ],
    ));
    BlocProvider.of<InfinityListBloc<BalanceModel>>(context).add(const ListReloadEvent(forceRequestBool: true));
  }
}
