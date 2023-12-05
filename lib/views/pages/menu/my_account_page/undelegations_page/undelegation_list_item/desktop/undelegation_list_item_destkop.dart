import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/views/pages/menu/my_account_page/undelegations_page/undelegation_list_item/desktop/undelegation_list_item_desktop_layout.dart';
import 'package:miro/views/widgets/generic/account/account_tile.dart';

class UndelegationListItemDesktop extends StatelessWidget {
  static const double height = 64;
  final UndelegationModel undelegationModel;

  const UndelegationListItemDesktop({
    required this.undelegationModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    List<String> tokens = undelegationModel.tokens.map((TokenAmountModel e) => e.toString()).toList();

    return UndelegationListItemDesktopLayout(
      height: height,
      validatorWidget: AccountTile(
        walletAddress: undelegationModel.validatorSimplifiedModel.walletAddress,
        addressVisibleBool: true,
        username: undelegationModel.validatorSimplifiedModel.moniker,
        avatarUrl: undelegationModel.validatorSimplifiedModel.logo,
      ),
      tokensWidget: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              tokens.join(' '),
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
            ),
          ),
        ],
      ),
      lockedUntilWidget: Text(
        DateFormat('d MMM y, HH:mm').format(undelegationModel.lockedUntil.toLocal()),
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(color: DesignColors.white1),
      ),
    );
  }
}
