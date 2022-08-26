import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_static_label.dart';

class TokenDropdownButton extends StatelessWidget {
  final bool disabled;
  final TokenAliasModel? tokenAliasModel;

  const TokenDropdownButton({
    this.disabled = false,
    this.tokenAliasModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TxInputStaticLabel(
            label: 'Token',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TokenAvatar(
                  iconUrl: tokenAliasModel?.icon,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  tokenAliasModel?.defaultTokenDenominationModel.name ?? '---',
                  style: textTheme.bodyText1!.copyWith(
                    color: DesignColors.white_100,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Icon(
          AppIcons.check,
          color: DesignColors.gray2_100,
          size: 16,
        ),
      ],
    );
  }
}
