import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';

class TokensDropdownListItem extends StatelessWidget {
  final TokenAliasModel tokenAliasModel;
  final VoidCallback onTap;

  const TokensDropdownListItem({
    required this.tokenAliasModel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: DesignColors.blue1_20,
      onTap: onTap,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TokenAvatar(
            size: 25,
            iconUrl: tokenAliasModel.icon,
          ),
        ],
      ),
      title: Text(
        tokenAliasModel.name,
        style: const TextStyle(
          color: DesignColors.white_100,
        ),
      ),
    );
  }
}
