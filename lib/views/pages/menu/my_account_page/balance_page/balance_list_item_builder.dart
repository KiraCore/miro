import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_desktop/balance_list_item_desktop.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_layout.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_mobile/balance_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

typedef ExpansionChangedCallback = void Function(bool status);

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
  Widget build(BuildContext context) {
    Widget desktopListItem = BalanceListItemDesktop(
      balanceModel: widget.balanceModel,
      expansionChangedCallback: _onExpansionChanged,
      favouritePressedCallback: _onFavouriteButtonPressed,
      hoverNotifier: hoverNotifier,
    );

    return BalanceListItemLayout(
      expandNotifier: expandNotifier,
      hoverNotifier: hoverNotifier,
      itemContent: ResponsiveWidget(
        largeScreen: desktopListItem,
        mediumScreen: desktopListItem,
        smallScreen: BalanceListItemMobile(
          balanceModel: widget.balanceModel,
          expansionChangedCallback: _onExpansionChanged,
          favouritePressedCallback: _onFavouriteButtonPressed,
          hoverNotifier: hoverNotifier,
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
}
