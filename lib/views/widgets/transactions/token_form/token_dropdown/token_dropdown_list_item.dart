import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/widgets/generic/icon_overlay.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/transactions/token_form/token_dropdown/token_dropdown_list_item_layout.dart';

class TokenDropdownListItem extends StatelessWidget {
  final VoidCallback onTap;
  final bool selected;
  final TokenAliasModel tokenAliasModel;
  final bool favourite;

  const TokenDropdownListItem({
    required this.onTap,
    required this.selected,
    required this.tokenAliasModel,
    this.favourite = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return TokenDropdownListItemLayout(
      onTap: onTap,
      selected: selected,
      icon: IconOverlay(
        icon: favourite
            ? const Icon(
                AppIcons.star,
                color: DesignColors.yellow_100,
                size: 12,
              )
            : null,
        child: TokenAvatar(
          iconUrl: tokenAliasModel.icon,
          size: 30,
        ),
      ),
      title: Text(
        tokenAliasModel.defaultTokenDenominationModel.name,
        style: textTheme.subtitle2!.copyWith(
          color: DesignColors.white_100,
        ),
      ),
      subtitle: Text(
        tokenAliasModel.name,
        style: textTheme.caption!.copyWith(
          color: DesignColors.gray2_100,
        ),
      ),
    );
  }
}
