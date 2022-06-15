import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/validators_list_bloc/validators_list_bloc.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/views/pages/menu/validators_page/validators_list_item_layout.dart';
import 'package:miro/views/widgets/buttons/star_button.dart';

class ValidatorsListItem extends StatelessWidget {
  final ValidatorModel validatorModel;
  final ScrollController scrollController;

  const ValidatorsListItem({
    required this.validatorModel,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValidatorsListItemLayout(
      favouriteButtonSection: StarButton(
        size: 25,
        value: validatorModel.favourite,
        onChanged: (bool value) async {
          await scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
          );
          if (validatorModel.favourite) {
            BlocProvider.of<ValidatorsListBloc>(context).removeFavourite(validatorModel);
          } else {
            BlocProvider.of<ValidatorsListBloc>(context).addFavourite(validatorModel);
          }
        },
      ),
      topSection: Text(validatorModel.top.toString(), textDirection: TextDirection.ltr),
      monikerSection: Text(validatorModel.moniker, textDirection: TextDirection.ltr),
      statusSection: Text(validatorModel.validatorStatus.toString(), textDirection: TextDirection.ltr),
    );
  }
}
