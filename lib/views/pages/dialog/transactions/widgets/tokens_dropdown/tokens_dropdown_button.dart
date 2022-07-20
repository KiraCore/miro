import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';

class TokenDropdownButton extends StatelessWidget {
  final TokenAliasModel? tokenAliasModel;

  const TokenDropdownButton({
    this.tokenAliasModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Token',
          style: TextStyle(fontSize: 10, color: DesignColors.gray2_100),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            TokenAvatar(
              size: 19,
              iconUrl: tokenAliasModel?.icon,
            ),
            const SizedBox(width: 6),
            Text(
              tokenAliasModel?.name ?? '---',
              style: const TextStyle(color: DesignColors.white_100),
            ),
          ],
        ),
      ],
    );
  }
}
