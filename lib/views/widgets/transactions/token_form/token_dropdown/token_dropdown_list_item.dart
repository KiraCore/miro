import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';

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

    return ListTile(
      dense: true,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      leading: SizedBox(
        height: double.infinity,
        width: 30,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Center(
                child: TokenAvatar(
                  iconUrl: tokenAliasModel.icon,
                  size: 30,
                ),
              ),
            ),
            if (favourite)
              const Positioned(
                bottom: 3,
                right: 0,
                child: Icon(
                  AppIcons.star,
                  color: DesignColors.yellow_100,
                  size: 12,
                ),
              ),
          ],
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
      trailing: selected
          ? const Icon(
              AppIcons.done,
              color: DesignColors.blue1_100,
            )
          : null,
    );
  }
}
