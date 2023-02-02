import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_add_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/events/favourites_remove_record_event.dart';
import 'package:miro/blocs/specific_blocs/list/favourites/favourites_bloc.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_item/desktop/validator_list_item_desktop.dart';
import 'package:miro/views/pages/menu/validators_page/validator_list_item/mobile/validator_list_item_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ValidatorListItemBuilder extends StatefulWidget {
  final ValidatorModel validatorModel;
  final ScrollController scrollController;

  const ValidatorListItemBuilder({
    required this.validatorModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatorListItemBuilder();
}

class _ValidatorListItemBuilder extends State<ValidatorListItemBuilder> {
  final ValueNotifier<bool> expandNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> hoverNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    Widget desktopListItem = ValidatorListItemDesktop(
      validatorModel: widget.validatorModel,
      onFavouriteButtonPressed: _onFavouriteButtonPressed,
    );

    Widget mobileListItem = ValidatorListItemMobile(
      validatorModel: widget.validatorModel,
      onFavouriteButtonPressed: _onFavouriteButtonPressed,
    );

    return ResponsiveWidget(
      largeScreen: desktopListItem,
      mediumScreen: mobileListItem,
      smallScreen: mobileListItem,
    );
  }

  Future<void> _onFavouriteButtonPressed(bool status) async {
    FavouritesBloc<ValidatorModel> favouritesBloc = BlocProvider.of<FavouritesBloc<ValidatorModel>>(context);

    await widget.scrollController.animateTo(
      widget.scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );

    if (widget.validatorModel.isFavourite) {
      favouritesBloc.add(FavouritesRemoveRecordEvent<ValidatorModel>(widget.validatorModel));
    } else {
      favouritesBloc.add(FavouritesAddRecordEvent<ValidatorModel>(widget.validatorModel));
    }
  }
}
